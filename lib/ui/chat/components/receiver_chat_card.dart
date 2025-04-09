import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/ui/chat/components/chat_receiver_container.dart';
import 'package:cobuild/ui/chat/components/message.dart';
import 'package:cobuild/ui/chat/components/message_time.dart';
import 'package:cobuild/ui/chat/estimates/estimated_quotation_message.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

// Receiver message view
class ReceiverChatCard extends StatelessWidget {
  final MessageModel model;

  const ReceiverChatCard({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatReceiverContainer(
          child: _messageData(),
        ),
        Gap(6.h),
        MessageTime(time: model.created),
      ],
    );
  }

  Widget _messageData() {
    switch (MessageType.getMessageType(model.messageType)) {
      case MessageType.text:
        return MessageWidget(model: model);
      case MessageType.quotation:
        return EstimatedQuotationMessage(model: model);
      default:
        return MessageWidget(model: model);
    }
  }
}
