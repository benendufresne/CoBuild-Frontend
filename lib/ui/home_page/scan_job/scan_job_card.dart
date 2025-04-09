import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title2.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scan job card :- to open scanner camera
class ScanJobCard extends StatelessWidget {
  const ScanJobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.scanJobQR);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: LinearGradient(colors: [
              AppColors.darkGreenGradient,
              AppColors.lightGreenGradient,
              AppColors.lightGreenGradient.withOpacity(0.915),
              AppColors.lightGreenGradient.withOpacity(0.9),
              // AppColors.white.withOpacity(0.12),
              // AppColors.white.withOpacity(0),
            ])),
        child:

            /// Content
            Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: KEdgeInsets.kOnly(t: 24.h, l: 18.w, r: 1.w, b: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header2(
                        heading: S.current.qrCodeJobSearchHeader,
                        fontSize: 17,
                        color: AppColors.white),
                    Gap(8.h),
                    Title2(
                        title: S.current.qrCodeJobSearchTitle,
                        fontSize: 14,
                        align: TextAlign.start,
                        color: AppColors.white),
                    Gap(14.h),
                    _scanNowButton()
                  ],
                ),
              ),
            ),
            ShowImage(image: AppImages.scanJobBackgroundImage, width: 104.w),
          ],
        ),
      ),
    );
  }

  Widget _scanNowButton() {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(6.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Header2(
              heading: S.current.scanNow,
              fontSize: 14,
              color: AppColors.primaryColor),
          Gap(16.w),
          ShowImage(
            image: AppImages.forwardGreen,
            height: 10.h,
            width: 10.h,
          )
        ],
      ),
    );
  }
}
