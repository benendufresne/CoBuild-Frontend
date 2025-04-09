import 'package:cobuild/models/chat/chat_inbox/chat_inbox_model.dart';

class ChatInboxListPaginationModel {
  List<ChatInboxModel> models;
  int nextHit;

  ChatInboxListPaginationModel({
    required this.models,
    required this.nextHit,
  });
}
