import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/models/chat/chat_room_model/chat_room_model.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';

abstract class ChatPageEvents extends BlocEvent {}

class ChatPageInitialEvent extends ChatPageEvents {}

class EnterChatRoomEvent extends ChatPageEvents {
  final String id;
  EnterChatRoomEvent({required this.id});
}

class SetChatRoomDataEvent extends ChatPageEvents {
  final ChatRoomModel model;
  SetChatRoomDataEvent({required this.model});
}

class GetMessagesListEvent extends ChatPageEvents {
  final String chatRoomId;
  final bool isNextPage;
  GetMessagesListEvent({required this.chatRoomId, this.isNextPage = false});
}

class ExitChatRoomEvent extends ChatPageEvents {
  final String id;
  ExitChatRoomEvent({required this.id});
}

class SendMessageEvent extends ChatPageEvents {
  final MessageModel? quotationReplyModel;
  final QuotationActionTypes? replyType;
  SendMessageEvent({this.quotationReplyModel, this.replyType});
}

class ReSendFailedMessageEvent extends ChatPageEvents {
  MessageModel model;
  ReSendFailedMessageEvent({required this.model});
}

class AddMessagesListEvent extends ChatPageEvents {
  final Map<String, dynamic> data;
  final bool isNextPage;
  AddMessagesListEvent({required this.data, this.isNextPage = false});
}

class UpdateMessageEvent extends ChatPageEvents {
  final MessageModel model;
  UpdateMessageEvent({required this.model});
}

class UpdateMessageStatusEvent extends ChatPageEvents {
  final String id, chatId;
  final MessageStatusEnum status;
  UpdateMessageStatusEvent(
      {required this.id, required this.chatId, required this.status});
}

class AddNewMessageLocallyEvent extends ChatPageEvents {
  final MessageModel model;
  AddNewMessageLocallyEvent({required this.model});
}

class MarkMessagesAsReadEvent extends ChatPageEvents {
  final String? id;
  MarkMessagesAsReadEvent({required this.id});

  String? get model => null;
}

class UpdateQuotationRequesetEvent extends ChatPageEvents {
  final MessageModel model;
  final QuotationActionTypes actionTypes;
  UpdateQuotationRequesetEvent(
      {required this.model, required this.actionTypes});
}

class ChatStatusUpdateEvent extends ChatPageEvents {
  MessageStatus type;
  ChatStatusUpdateEvent({this.type = MessageStatus.rejected});
}
