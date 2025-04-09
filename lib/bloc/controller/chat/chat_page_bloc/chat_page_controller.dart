import 'dart:async';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:cobuild/utils/services/network_service.dart';
import 'package:cobuild/utils/services/socket/socket_service_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';

class ChatPageController extends Bloc<ChatPageEvents, ChatPageState> {
  ChatPageController()
      : super(ChatPageState(
          state: BlocState.none,
          stateStore: ChatPageStateStore(),
          event: ChatPageInitialEvent(),
          response: null,
        )) {
    on<SendMessageEvent>(_sendMessage);
    on<ReSendFailedMessageEvent>(_resendMessage);
    on<EnterChatRoomEvent>(_enterChatRoomEvent);
    on<SetChatRoomDataEvent>(_setChatRoomData);
    on<GetMessagesListEvent>(_getMessagesListEvent);
    on<AddMessagesListEvent>(_addMessageList);
    on<AddNewMessageLocallyEvent>(_addMessageLocally);
    on<UpdateMessageEvent>(_updateMessage);
    on<UpdateMessageStatusEvent>(_updateMessageStatus);
    on<UpdateQuotationRequesetEvent>(_updateQuotationRequesetEvent);
    on<MarkMessagesAsReadEvent>(_markMessagesRead);
    on<ChatStatusUpdateEvent>(_updateChatStatusEvent);
    on<ExitChatRoomEvent>(_exitChatRoomEvent);
  }

  // Send Message
  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    String chatId = state.stateStore.chatRoomModel?.chatId ?? '';
    String localMessageId = ObjectId().toString();
    MessageType type = MessageType.text;
    MessageModel model = MessageModel(
      senderId: AppPreferences.userId,
      chatId: chatId,
      message: state.stateStore.messageController.text.trim(),
      messageType: type.backendEnum,
      created: DateTime.now().millisecondsSinceEpoch,
      localMessageId: localMessageId,
    );
    if (event.quotationReplyModel != null) {
      printCustom("loca msg id is ${event.quotationReplyModel?.toJson()}");
      model.messageType = MessageType.quotationReply.backendEnum;
      model.messageId = event.quotationReplyModel?.localMessageId ??
          event.quotationReplyModel?.sid;
      MessageStatus status = MessageStatus.accepted;
      if (event.replyType == QuotationActionTypes.accept) {
        status = MessageStatus.accepted;
      } else if (event.replyType == QuotationActionTypes.reject) {
        status = MessageStatus.rejected;
      } else {
        status = MessageStatus.bidAgain;
      }
      model.status = status.backendEnum;
      model.message = status.message;
    }
    add(AddNewMessageLocallyEvent(model: model));
    SocketHandlerService().sendMsg(
      model: model,
      onDelay: (id) {
        add(UpdateMessageStatusEvent(
            id: id, chatId: chatId, status: MessageStatusEnum.delay));
      },
      onFailed: (id) {
        add(UpdateMessageStatusEvent(
            id: id, chatId: chatId, status: MessageStatusEnum.failed));
      },
    );
    state.stateStore.messageController.clear();
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _resendMessage(
    ReSendFailedMessageEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    if (event.model.chatId?.isEmpty ?? true) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    SocketHandlerService().sendMsg(
      model: event.model,
      onDelay: (id) {
        add(UpdateMessageStatusEvent(
            id: id,
            chatId: event.model.chatId ?? '',
            status: MessageStatusEnum.delay));
      },
      onFailed: (id) {
        add(UpdateMessageStatusEvent(
            id: id,
            chatId: event.model.chatId ?? '',
            status: MessageStatusEnum.failed));
      },
    );
    state.stateStore.messageController.clear();
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _enterChatRoomEvent(
    EnterChatRoomEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    state.stateStore.dispose();
    bool isInternet = await NetworkHelper.checkConnection();
    if (!isInternet) {
      showSnackBar(message: S.current.noInternet);
      emit(state.copyWith(state: BlocState.noInternet, event: event));
      return;
    }
    await SocketHandlerService().enterChatRoom(chatId: event.id);
  }

  FutureOr<void> _setChatRoomData(
    SetChatRoomDataEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    state.stateStore.chatRoomModel = event.model;
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _markMessagesRead(
    MarkMessagesAsReadEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    for (var message in state.stateStore.messagesList) {
      if ((message.isRead?.length ?? 0) >= 2) {
        break;
      } else {
        message.isRead?.add('dummyId');
      }
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _getMessagesListEvent(
    GetMessagesListEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    if (event.isNextPage && state.stateStore.messagesList.isEmpty) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.isNextPage) {
      SocketHandlerService().getMessagesList(
          chatId: event.chatRoomId,
          lastMsgId: state.stateStore.messagesList.last.sid);
    } else {
      SocketHandlerService().getMessagesList(chatId: event.chatRoomId);
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _addMessageList(
    AddMessagesListEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    if (event.data[ApiKeys.data] != null) {
      List<dynamic> list = event.data[ApiKeys.data];
      List<MessageModel> requestList =
          list.map((e) => MessageModel.fromJson(e)).toList();
      if (event.isNextPage) {
        state.stateStore.messagesList.addAll(requestList);
      } else {
        state.stateStore.messagesList = requestList;
      }
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _updateMessageStatus(
    UpdateMessageStatusEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    int index = state.stateStore.messagesList
        .indexWhere((message) => (message.localMessageId == event.id));
    if (index > -1) {
      state.stateStore.messagesList[index].messageLocalStatus =
          event.status.backendEnum;
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _addMessageLocally(
    AddNewMessageLocallyEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    state.stateStore.messagesList.insert(0, event.model);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _updateMessage(
    UpdateMessageEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    if (event.model.senderId == null) {
      return;
    }
    int messageIndex = state.stateStore.messagesList.indexWhere((message) =>
        ((event.model.sid == message.sid) ||
            (event.model.sid == message.localMessageId)));
    if (messageIndex > -1) {
      state.stateStore.messagesList[messageIndex] = event.model;
    } else {
      state.stateStore.messagesList.insert(0, event.model);
    }
    if (MessageType.getMessageType(event.model.messageType) ==
        MessageType.quotationReply) {
      if (event.model.message == MessageStatus.rejected.message) {
        _updateChatStatus(MessageStatus.rejected);
      }
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _updateChatStatusEvent(
    ChatStatusUpdateEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    _updateChatStatus(event.type);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  _updateChatStatus(MessageStatus type) {
    state.stateStore.chatRoomModel?.status = type.backendEnum;
  }

  FutureOr<void> _updateQuotationRequesetEvent(
    UpdateQuotationRequesetEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    add(SendMessageEvent(
        quotationReplyModel: event.model, replyType: event.actionTypes));
  }

  FutureOr<void> _exitChatRoomEvent(
    ExitChatRoomEvent event,
    Emitter<ChatPageState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    state.stateStore.dispose();
    SocketHandlerService().exitChatRoom(chatId: event.id);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  MessageReaadStatusEnum getMessageReadStatus(MessageModel model) {
    if ((model.isRead?.length ?? 0) > 1) {
      return MessageReaadStatusEnum.seen;
    } else if ((model.isDelivered?.length ?? 0) > 0) {
      return MessageReaadStatusEnum.sent;
    }
    return MessageReaadStatusEnum.none;
  }
}
