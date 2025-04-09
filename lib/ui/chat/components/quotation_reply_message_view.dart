import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/ui/chat/components/chat_receiver_container.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Estimate request chat :- Quotation reply view
class QuotationReplyMessageWidget extends StatelessWidget {
  final MessageModel model;
  const QuotationReplyMessageWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ChatReceiverContainer(
          child: AppRichText(children: [
            AppTextSpan(
              text: S.current.quotationReply,
              style: AppStyles().regularBold.colored(AppColors.black),
            ),
            if (model.request != null)
              AppTextSpan(
                text: CommonBottomSheetWidgets.serviceSubType(model.request!),
                style: AppStyles().regularSemiBold.colored(AppColors.blackText),
              )
          ]),
        ),
        Text(model.message?.trim() ?? '',
            style: AppStyles().regularRegular.copyWith(color: AppColors.white)),
      ],
    );
  }
}
