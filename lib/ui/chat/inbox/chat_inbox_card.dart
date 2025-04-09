import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/chat/chat_inbox/chat_inbox_model.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/chat/components/chat_profile_image.dart';
import 'package:cobuild/ui/components/jobs/job_card_title_image.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';

/// Chat inbox card
class ChatInboxCard extends StatelessWidget {
  final ChatInboxModel model;
  final bool isFirstTile;
  final bool isLastTile;

  const ChatInboxCard(
      {super.key,
      required this.model,
      this.isFirstTile = false,
      this.isLastTile = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () {
        context.pushNamed(AppRoutes.chatPage, extra: {AppKeys.id: model.sId});
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        padding: EdgeInsets.only(top: isFirstTile ? 0 : fieldGap),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            (model.chatMode == ChatMode.job.backendEnum)
                ? const JobCardTitleImage()
                : _getMediaModel() != null
                    ? EstimateRequestMediaView(
                        isChatPage: true, model: _getMediaModel()!)
                    : const ChatProfileImage(),
            Gap(15.w),
            // Description
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _message()),
                      if (getMessage.isNotEmpty) ...[
                        Gap(10.w),
                        // Time and Unread Count
                        _timeAndUnreadCount()
                      ]
                    ],
                  ),
                  Padding(
                    padding: KEdgeInsets.kOnly(t: 2.h),
                    child: const Divider(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MediaModel? _getMediaModel() {
    if (model.request?.media?.isNotEmpty ?? false) {
      return MediaModel(
          media: model.request?.media, mediaType: model.request?.mediaType);
    } else if (model.report?.media?.isNotEmpty ?? false) {
      return model.report?.media?.first;
    }
    return null;
  }

  Widget _message() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            (model.chatMode == ChatMode.job.backendEnum)
                ? model.job?.title ?? ''
                : (model.request != null)
                    ? CommonBottomSheetWidgets.serviceSubType(model.request!)
                    : (model.report != null)
                        ? model.report?.type ?? ''
                        : '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppStyles().mediumBold.colored(AppColors.black)),
        if (getMessage.isNotEmpty) ...[
          Gap(7.h),
          Text(getMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles()
                  .smallSemiBold
                  .colored(AppColors.black.withOpacity(0.5)))
        ]
      ],
    );
  }

  Widget _timeAndUnreadCount() {
    int unread = model.unreadMessages ?? 0;
    int? lastMessageTime;
    // model.created ?? DateTime.now().millisecondsSinceEpoch;
    if (model.lastMsgCreated != null && model.lastMsgCreated != 0) {
      lastMessageTime =
          model.lastMsgCreated ?? DateTime.now().millisecondsSinceEpoch;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(lastMessageTime == null ? '' : timeAgo(lastMessageTime),
            style: AppStyles().smallSemiBold),
        Gap(7.h),
        if (model.chatMode?.isNotEmpty ?? false) ...[
          Text(ChatMode.displayName(model.chatMode),
              style: AppStyles().regularBold.colored(AppColors.primaryColor)),
          Gap(7.h),
        ],
        // Unread count
        if (unread > 0 || (!isActive))
          Row(
            children: [
              if (!isActive) ...[
                Text(chatStatus,
                    style: AppStyles()
                        .smallRegular
                        .colored(AppColors.rejectedStatusColor)),
              ],
              if (unread > 0)
                Container(
                    padding: KEdgeInsets.k(h: 8.w, v: 2.h),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.rejectedStatusColor,
                        shape: BoxShape.circle),
                    child: Text(unread > 9 ? "9+" : unread.toString(),
                        style: AppStyles()
                            .smallSemiBold
                            .colored(AppColors.white))),
            ],
          )
      ],
    );
  }

  bool get isActive {
    return (model.inboxStatus == MessageStatus.active.backendEnum);
  }

  String get chatStatus {
    switch (MessageStatus.getStatusType(model.inboxStatus)) {
      case MessageStatus.accepted:
      case MessageStatus.bidAgain:
      case MessageStatus.active:
        return '';
      case MessageStatus.rejected:
        return S.current.rejected;
      case MessageStatus.completed:
        return S.current.completed;
      case MessageStatus.canceled:
        return S.current.canceled;
    }
  }

  String get getMessage {
    if (model.lastMessage?.isNotEmpty ?? false) {
      MessageModel messageModel = model.lastMessage![0];
      switch (MessageType.getMessageType(messageModel.messageType)) {
        case MessageType.text:
        case MessageType.quotationReply:
          return messageModel.message?.trim() ?? '';
        case MessageType.quotation:
          return messageModel.notes?.trim() ?? '';
        case MessageType.request:
          return '';
      }
    }
    return '';
  }
}
