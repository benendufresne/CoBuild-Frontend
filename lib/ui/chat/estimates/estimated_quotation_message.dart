import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Estimated quotation(shared by admin) message view
class EstimatedQuotationMessage extends StatelessWidget {
  final MessageModel model;
  const EstimatedQuotationMessage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.current.quotation, style: AppStyles().regularSemiBold),
            if (model.amount != null)
              AppRichText(
                children: [
                  AppTextSpan(
                      text: "${S.current.amount}: ",
                      style: AppStyles().regularSemiBold),
                  AppTextSpan(
                      text: "\$${model.amount ?? ''}/${S.current.day}",
                      style: AppStyles().regularBolder)
                ],
              ),
          ],
        ),
        Gap(13.h),
        // Title and estimate days
        Row(
          children: [
            if (model.request?.media?.isNotEmpty ?? false) ...[
              EstimateRequestMediaView(
                  isChatPage: true,
                  model: MediaModel(
                      media: model.request?.media,
                      mediaType: model.request?.mediaType)),
              Gap(12.w)
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.request != null)
                    Text(
                        CommonBottomSheetWidgets.serviceSubType(model.request!),
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles().mediumBold),
                  if (model.estimatedDays?.isNotEmpty ?? false)
                    AppRichText(
                      children: [
                        AppTextSpan(
                            text: "${S.current.estimatedDays}: ",
                            style: AppStyles().regularRegular),
                        AppTextSpan(
                            text:
                                "${model.estimatedDays} ${model.estimatedDays == "1" ? S.current.day : S.current.days}",
                            style: AppStyles().regularRegular)
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
        Gap(8.h),
        // Message
        if (model.notes?.isNotEmpty ?? false) ...[
          Text(S.current.message, style: AppStyles().regularSemiBold),
          Gap(6.h),
          Container(
              width: deviceWidth,
              padding: KEdgeInsets.k(h: 10.w, v: 6.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: AppColors.black.withOpacity(0.05)),
              child: Text(model.notes ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles().smallRegular)),
          Gap(8.h)
        ],
        _actionButtons()
      ],
    );
  }

  Widget _actionButtons() {
    if (model.status == MessageStatus.active.backendEnum) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          actionButton(QuotationActionTypes.accept),
          Gap(12.w),
          actionButton(QuotationActionTypes.bidAgain),
          Gap(12.w),
          actionButton(QuotationActionTypes.reject)
        ],
      );
    } else {
      return getActionedWidget();
    }
  }

  Widget getActionedWidget() {
    return Text(MessageStatus.getStatusType(model.status).message,
        style: AppStyles().regularSemiBold.colored(
            getColorAfterAction(MessageStatus.getStatusType(model.status))));
  }

  Color getColorAfterAction(MessageStatus type) {
    switch (type) {
      case MessageStatus.accepted:
        return AppColors.primaryColor;
      case MessageStatus.bidAgain:
        return AppColors.blackText;
      case MessageStatus.rejected:
      case MessageStatus.completed:
      case MessageStatus.canceled:
      case MessageStatus.active:
        return AppColors.rejectedStatusColor;
    }
  }

  Widget actionButton(QuotationActionTypes type) {
    return InkWell(
      onTap: () {
        onTap(type);
      },
      child: Container(
        padding: KEdgeInsets.k(h: 8.w, v: 4.h),
        decoration: BoxDecoration(
          color: getColor(type),
          border: Border.all(color: textColor(type)),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(type.displayName,
            style: AppStyles().smallSemiBold.colored(textColor(type))),
      ),
    );
  }

  void onTap(QuotationActionTypes type) {
    ChatPageController controller = ctx.read<ChatPageController>();
    if (MessageStatus.getStatusType(
            controller.state.stateStore.chatRoomModel?.status) ==
        MessageStatus.rejected) {
      return;
    }
    switch (type) {
      case QuotationActionTypes.accept:
        model.status = MessageStatus.accepted.backendEnum;
        controller.add(UpdateQuotationRequesetEvent(
            model: model, actionTypes: QuotationActionTypes.accept));
      case QuotationActionTypes.bidAgain:
        model.status = MessageStatus.bidAgain.backendEnum;
        controller.add(UpdateQuotationRequesetEvent(
            model: model, actionTypes: QuotationActionTypes.bidAgain));
      case QuotationActionTypes.reject:
        model.status = MessageStatus.rejected.backendEnum;
        controller.add(UpdateQuotationRequesetEvent(
            model: model, actionTypes: QuotationActionTypes.reject));
    }
  }

  Color getColor(QuotationActionTypes type) {
    switch (type) {
      case QuotationActionTypes.accept:
        return AppColors.primaryColor;
      case QuotationActionTypes.bidAgain:
        return AppColors.primaryColor.withOpacity(0.05);
      case QuotationActionTypes.reject:
        return AppColors.rejectedStatusColor.withOpacity(0.05);
    }
  }

  Color textColor(QuotationActionTypes type) {
    switch (type) {
      case QuotationActionTypes.accept:
        return AppColors.white;
      case QuotationActionTypes.bidAgain:
        return AppColors.primaryColor;
      case QuotationActionTypes.reject:
        return AppColors.rejectedStatusColor;
    }
  }
}
