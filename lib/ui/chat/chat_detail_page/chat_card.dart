import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/ui/chat/components/message_time.dart';
import 'package:cobuild/ui/chat/components/receiver_chat_card.dart';
import 'package:cobuild/ui/chat/components/sender_chat_card.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:flutter/material.dart';

/// Chat Message Card
class ChatCard extends StatelessWidget {
  final MessageModel model;
  final bool showDateHeader;
  const ChatCard({super.key, required this.model, this.showDateHeader = false});

  @override
  Widget build(BuildContext context) {
    bool sender = model.senderId == AppPreferences.userId;
    return Column(
        crossAxisAlignment:
            (sender) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (showDateHeader)
            MessageTime(time: model.created).chatDateSeparator(),
          sender ? SenderChatCard(model: model) : ReceiverChatCard(model: model)
        ]);
  }
}
