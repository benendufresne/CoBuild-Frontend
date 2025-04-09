import 'dart:async';
import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/chat/chat_room_model/chat_room_model.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:cobuild/utils/services/network_service.dart';
import 'package:cobuild/utils/services/socket/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Class to handle chat :- through socket events
int maxChatMessagesInAPage = 20;
int maxInboxCountInAPage = 500;
DateTime? lastSessionExpiredMessageTime;

class SocketHandlerService {
  static final SocketHandlerService _singleton =
      SocketHandlerService._internal();
  ChatInboxController inboxController = ctx.read<ChatInboxController>();
  ChatPageController chatPageController = ctx.read<ChatPageController>();

  factory SocketHandlerService() {
    return _singleton;
  }

  SocketHandlerService._internal();

  Future reconnectIfNull() async {
    if (!AppSocketService().isSocketActive()) {
      await AppSocketService().initSocket();
      printLocal("appSocketService attempt to reconnect");
    }
  }

  /// Listeneres activated on init ///
  void _authErrorListener() async {
    AppSocketService().socket?.on(SocketKeys.authError, (data) {
      printCustom('authError socket $data');
      if (data[ApiKeys.statusCode] == ApiStatusCode.sessionExpired) {
        _showSessionExpiredMessage(
            data[ApiKeys.message] ?? S.current.somethingWentWrong);
        ctx.read<AppController>().add(LogoutEvent(callApi: false));
      } else {}
    });
  }

  _showSessionExpiredMessage(String? message) {
    DateTime currentTime = DateTime.now();
    if (lastSessionExpiredMessageTime == null ||
        currentTime
                .difference(lastSessionExpiredMessageTime ?? currentTime)
                .inSeconds >
            15) {
      lastSessionExpiredMessageTime = currentTime;
      showSnackBar(message: message ?? S.current.somethingWentWrong);
    }
  }

  void _socketConnectedListener() async {
    AppSocketService().socket?.on(SocketKeys.socketConnected, (data) {
      if (data[ApiKeys.statusCode] == 200) {
        getInboxListing();
        // Inbox
        _inboxListingListener();
        // Listen if any unread messages
        _listenIfAnyUnreadMessages();
        // Listen job status update
        _listenJobStatusUpdate();
      } else {}
    });
  }

  void _inboxListingListener() async {
    AppSocketService().socket?.on(SocketKeys.inboxListing, (data) {
      updateInboxListing(data);
    });
  }

  void _listenIfAnyUnreadMessages() {
    AppSocketService()
        .socket
        ?.emitWithAck(SocketKeys.unReadNotify, {}, ack: (data) {});
    AppSocketService().socket?.on(SocketKeys.unReadNotify, (data) {
      if (data[SocketKeys.unread] != null) {
        inboxController
            .add(UpdateInboxReadStatus(isUnRead: data[SocketKeys.unread]));
      }
    });
  }

  void _listenJobStatusUpdate() {
    AppSocketService().socket?.on(SocketKeys.refreshInbox, (data) {
      if (data != null && data[ApiKeys.status] != null) {
        getInboxListing();
        chatPageController.add(ChatStatusUpdateEvent(
            type: MessageStatus.getStatusType(data[ApiKeys.status])));
      }
    });
  }

  void startSocketListener() {
    /// Connection
    _authErrorListener();
    _socketConnectedListener();
  }
  //     --------     //////////

  ///   -------  Inbox Events -----   ///
  void getInboxListing({String? searchText, int pageNo = 1}) async {
    await reconnectIfNull();
    try {
      Map<String, Object?> data = {
        SocketKeys.pageNo: pageNo,
        SocketKeys.limit: maxInboxCountInAPage,
        SocketKeys.searchKey: searchText
      };
      AppSocketService().socket?.emitWithAck(SocketKeys.inboxListing, data,
          ack: (data) {
        updateInboxListing(data);
      });
    } catch (e) {
      printCustom('get inbox called: ${e.toString()} ');
    }
  }

  void updateInboxListing(dynamic data) {
    if (data != null && data[ApiKeys.data] != null) {
      inboxController.add(UpdataInboxListDataEvent(data: data));
    }
  }
  //  ------- End Inbox Events -----   ///

  /// Chat Room Events
  Future<void> enterChatRoom({required String chatId}) async {
    await reconnectIfNull();
    try {
      await getMessagesList(chatId: chatId);
      AppSocketService().socket?.emitWithAck(
          SocketKeys.enterChatRoom, {SocketKeys.chatId: chatId}, ack: (data) {
        _updateChatRoomData(data);
      });
    } catch (e) {
      printCustom('enter chat: ${e.toString()} ');
    }
  }

  void _updateChatRoomData(dynamic data) {
    if (data != null && data is Map<String, dynamic>) {
      ChatRoomModel model = ChatRoomModel.fromJson(data);
      chatPageController.add(SetChatRoomDataEvent(model: model));
    }
  }

  Future<void> getMessagesList(
      {required String chatId, String? lastMsgId}) async {
    await reconnectIfNull();
    if (lastMsgId == null) {
      _listenMessageUpdates(chatId);
    }
    try {
      Map<String, Object?> data = {
        SocketKeys.pageNo: 1,
        SocketKeys.limit: maxChatMessagesInAPage,
        ApiKeys.chatId: chatId,
        SocketKeys.lastMsgId: lastMsgId
      };
      AppSocketService().socket?.emitWithAck(SocketKeys.getMessagesList, data,
          ack: (data) {
        _updateMessageList(data, isNextPage: lastMsgId != null);
      });
      printCustom('get chat messages called ');
    } catch (e) {
      printCustom('enter chat: ${e.toString()} ');
    }
  }

  void _listenMessageUpdates(String chatId) async {
    await reconnectIfNull();
    AppSocketService().socket?.on(chatId, (data) {
      printCustom('Listen messages updates called $data');
      if (data != null && data[SocketKeys.eventType] != null) {
        String eventType = data[SocketKeys.eventType];
        if (eventType == SocketKeys.sendMsg && data[ApiKeys.data] != null) {
          MessageModel model = MessageModel.fromJson(data[ApiKeys.data]);
          chatPageController.add(UpdateMessageEvent(model: model));
        } else if (eventType == SocketKeys.chatReadStatus &&
            data[ApiKeys.data] != null) {
          chatPageController
              .add(MarkMessagesAsReadEvent(id: data[ApiKeys.chatId]));
        } else if (eventType == SocketKeys.rejectRequest) {
          chatPageController.add(ChatStatusUpdateEvent());
        }
      }
    });
  }

  void _closeMessageListener(String chatId) async {
    await reconnectIfNull();
    AppSocketService().socket?.off(chatId, (data) {
      printCustom('Listen messages turned off $data');
    });
  }

  void _updateMessageList(dynamic data, {bool isNextPage = false}) {
    chatPageController
        .add(AddMessagesListEvent(data: data, isNextPage: isNextPage));
  }

  void exitChatRoom({required String chatId}) async {
    await reconnectIfNull();
    try {
      _closeMessageListener(chatId);
      AppSocketService().socket?.emitWithAck(
          SocketKeys.leftChatRoom, {SocketKeys.chatId: chatId}, ack: (data) {
        printCustom("Chat Room left");
      });
    } catch (e) {
      printCustom('left chat: ${e.toString()} ');
    }
  }

  void sendMsg(
      {required MessageModel model,
      required Function onDelay,
      required Function onFailed}) async {
    await reconnectIfNull();
    Timer dalayTimer = Timer(const Duration(milliseconds: 800), () {
      onDelay(model.localMessageId);
    });
    Timer failedTimer = Timer(const Duration(seconds: 5), () {
      onFailed(model.localMessageId);
      return;
    });
    if (!(await NetworkHelper.checkConnection())) {
      showOfflineDialog();
      return;
    }
    printCustom('sendMsg param ${model.toJson()}');
    AppSocketService().socket?.emitWithAck(
        model.messageType == MessageType.quotationReply.backendEnum
            ? SocketKeys.quotationReply
            : SocketKeys.sendMsg,
        model.toJson()..removeWhere((key, value) => value == null),
        ack: (data) {
      if (data[ApiKeys.statusCode] == ApiStatusCode.socketSuccessResponse) {
        model.messageLocalStatus = MessageStatusEnum.sent.backendEnum;
        failedTimer.cancel();
        dalayTimer.cancel();
      }
    });
  }
  // -----------   End   ----------    ///

  void markAllRead({
    required Function markRead,
    required String chatId,
  }) async {
    await reconnectIfNull();

    Map<String, Object?> data = {
      "chatId": chatId,
    };

    printLocal('markAllRead param $data ');

    AppSocketService().socket?.emitWithAck(SocketKeys.markReadAll, data,
        ack: (data) {
      printCustom('markAllRead $data');
      markRead(data);
    });
  }

  void messageListener({required Function onMessageListen}) async {
    try {
      await reconnectIfNull();

      if (AppSocketService().socket?.hasListeners(SocketKeys.receiveMsg) ??
          false) {
        printLocal('msg_received Listener already attached');
        return;
      }

      AppSocketService().socket!.on(SocketKeys.receiveMsg, (data) {
        printLocal('msg_received Listener $data');
        onMessageListen(data);
      });
    } catch (e) {
      printCustom('msg_received err:: ${e.toString()} ');
    }
  }

  void typingListener({required Function onTypingListen}) async {
    try {
      await reconnectIfNull();

      if (AppSocketService().socket?.hasListeners(SocketKeys.typingUpdate) ??
          false) {
        printLocal('typing_update Listener already attached');
        return;
      }

      AppSocketService().socket!.on(SocketKeys.typingUpdate, (data) {
        printLocal('typing_update Listener $data');
        onTypingListen(data);
      });
    } catch (e) {
      printCustom('typing_update err:: ${e.toString()} ');
    }
  }

  void typingInChat({
    required Function typingInChat,
    required String chatId,
  }) async {
    await reconnectIfNull();

    try {
      Map<String, Object?> data = {"chatId": chatId, "isText": true};

      printLocal('typingInChat param $data ');

      AppSocketService().socket?.emitWithAck(SocketKeys.typingUpdate, data,
          ack: (data) {
        printCustom('typingInChat $data');
        typingInChat(data);
      });
    } catch (e) {
      printCustom('typingInChat: ${e.toString()} ');
    }
  }

  void disconnectTypingListener() {
    AppSocketService().socket?.off(
      SocketKeys.typingUpdate,
      (data) {
        printCustom('disconnectTypingListener $data');
      },
    );
  }
}
