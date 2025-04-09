import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_media_placeholder.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/report_damage/damage_status.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Damage report card
class DamageCard extends StatelessWidget {
  final DamageModel model;
  const DamageCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.reportDetailsPage,
            extra: {AppKeys.id: model.sId});
      },
      child: Container(
        padding: KEdgeInsets.k16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
        child: Column(
          children: [
            // Image and data
            _imageAndData(),
            Padding(
              padding: KEdgeInsets.k(v: 12.h),
              child: const AppCommonDivider(),
            ),
            // Address and Time
            _addressAndTime()
          ],
        ),
      ),
    );
  }

  Widget _imageAndData() {
    return Row(
      children: [
        (model.media?.isEmpty ?? true)
            ? const EstimateMediaPlaceholder()
            : EstimateRequestMediaView(
                model: (model.media?.isEmpty ?? true)
                    ? MediaModel()
                    : model.media!.first),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.type ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppStyles().mediumBold.colored(AppColors.black)),
              Gap(7.h),
              Text(model.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles()
                      .smallSemiBold
                      .colored(AppColors.black.withOpacity(0.5))),
              Gap(10.h),
              DamageReportStatus(model: model),
            ],
          ),
        )
      ],
    );
  }

  Widget _addressAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Address
        Expanded(child: _address()),
        Gap(6.w),
        // Time
        if (model.created != null) _time(),
      ],
    );
  }

  Widget _address() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowImage(
            image: AppImages.locationIconGreen, height: 16.h, width: 12.w),
        Gap(5.w),
        Expanded(
            child: Text(model.location?.address ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles().smallBold)),
      ],
    );
  }

  Widget _time() {
    return AppRichText(children: [
      AppTextSpan(
          text: "${S.current.reportedOn}:",
          style: AppStyles().smallSemiBold.colored(AppColors.lightGreyText)),
      AppTextSpan(
          text: formatDate(model.created), style: AppStyles().smallSemiBold)
    ]);
  }
}
