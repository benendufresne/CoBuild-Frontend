import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Estimate request Message view :- Not used currently
class EstimateRequestMessage extends StatelessWidget {
  final MessageModel model;
  const EstimateRequestMessage({super.key, required this.model});

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
            Text(S.current.yourQuote,
                style: AppStyles().regularSemiBold.colored(AppColors.white)),
            const ShowImage(image: AppImages.editIcon),
          ],
        ),
        Gap(13.h),
        // Title and estimate days
        Row(
          children: [
            EstimateRequestMediaView(
                isChatPage: true, model: MediaModel(media: '', mediaType: '')),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Directional Drilling alksdf asdlkg sdlg dslag jsdla gjlds; glksaj glskad glkdsagj jsdl gsdflkgs hlkhafs",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles().mediumBold.colored(AppColors.white)),
                  Text(
                      "Directional Drilling alsk dsalkgdaslg adslgkadsglsdgalsd glaksd gs",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles()
                          .regularSemiBold
                          .colored(AppColors.white.withOpacity(0.8))),
                ],
              ),
            )
          ],
        ),
        Gap(8.h),
        // Message
        Text(S.current.message,
            style: AppStyles().regularSemiBold.colored(AppColors.white)),
        Gap(6.h),
        Container(
            width: deviceWidth,
            padding: KEdgeInsets.k(h: 10.w, v: 6.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: AppColors.white.withOpacity(0.05)),
            child: Text(
                "I have provided the kdsaj gkasdlg lskg dskl gdkls gdslk gdslk glds gdlsk gdslk gsaskj dasdg dskg .",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppStyles()
                    .smallRegular
                    .colored(AppColors.appBackGroundColor))),
      ],
    );
  }
}
