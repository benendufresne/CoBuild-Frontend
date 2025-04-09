import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/ui/chat/components/chat_sender_container.dart';
import 'package:cobuild/ui/chat/components/message.dart';
import 'package:cobuild/ui/chat/components/message_time.dart';
import 'package:cobuild/ui/chat/components/quotation_reply_message_view.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sender Message view
class SenderChatCard extends StatelessWidget {
  final MessageModel model;

  const SenderChatCard({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (model.messageLocalStatus ==
                MessageStatusEnum.failed.backendEnum)
              IconButton(
                  onPressed: () {
                    context
                        .read<ChatPageController>()
                        .add(ReSendFailedMessageEvent(model: model));
                  },
                  icon: const Icon(Icons.refresh,
                      color: AppColors.errorTextFieldColor)),
            ChatSenderContainer(
              child: _messageView(),
            ),
          ],
        ),
        Gap(6.h),
        (model.messageLocalStatus == MessageStatusEnum.delay.backendEnum)
            ? Text(
                S.current.sendingMessage,
                style: AppStyles().regularRegular,
              )
            : (model.messageLocalStatus == MessageStatusEnum.failed.backendEnum)
                ? Text(
                    S.current.failed,
                    style: AppStyles().regularRegular,
                  )
                : _msgTimeAndSeenStatus(),
      ],
    );
  }

  Widget _messageView() {
    //  EstimateRequestMessage(model: model)

    switch (MessageType.getMessageType(model.messageType)) {
      case MessageType.text:
        return MessageWidget(model: model);
      case MessageType.quotation:
        return MessageWidget(model: model);
      case MessageType.quotationReply:
        return QuotationReplyMessageWidget(model: model);
      case MessageType.request:
        return MessageWidget(model: model);
    }
  }

  Widget _msgTimeAndSeenStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MessageTime(time: model.created),
        SizedBox(width: 4.w),
        _messageSeenIcon(),
      ],
    );
  }

  Widget _messageSeenIcon() {
    MessageReaadStatusEnum status =
        ctx.read<ChatPageController>().getMessageReadStatus(model);
    switch (status) {
      case MessageReaadStatusEnum.sent:
        return Icon(
          Icons.check,
          color: AppColors.blackText,
          size: 18.h,
        );
      case MessageReaadStatusEnum.seen:
        return ShowImage(
            image: AppImages.messageSeen,
            height: 18.h,
            width: 18.h,
            color: AppColors.primaryColor);
      case MessageReaadStatusEnum.none:
        return const SizedBox();
    }
  }
}
