import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Estimate and discover Options
class EstimateAndDiscoverCard extends StatelessWidget {
  const EstimateAndDiscoverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _card(
              backgroundColor: AppColors.seaColor.withOpacity(0.6),
              image: AppImages.estimate,
              backgroundImage: AppImages.estimatesBackground,
              title: S.current.estimates,
              iconColor: AppColors.lightSeaColor,
              onTap: () {
                context.pushNamed(AppRoutes.estimates);
              }),
        ),
        Gap(20.w),
        Expanded(
          child: _card(
              backgroundColor: AppColors.inkColor.withOpacity(0.4),
              image: AppImages.opportunity,
              backgroundImage: AppImages.mapBackground,
              title: S.current.opportunityMap,
              iconColor: AppColors.lightInkColor,
              onTap: () {
                context.pushNamed(AppRoutes.dynamicMap);
              }),
        )
      ],
    );
  }

  Widget _card(
      {required Color backgroundColor,
      required Color iconColor,
      required String image,
      required String backgroundImage,
      required String title,
      required Function onTap}) {
    return InkWell(
        onTap: () => {onTap()},
        child: Stack(children: [
          Container(
            height: 125.h,
            padding: KEdgeInsets.kOnly(l: 14.w, r: 14.w, t: 18.h, b: 14.h),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowImage(
                  image: image,
                  height: 36.h,
                  width: 36.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Header2(
                        heading: title,
                        fontSize: 16,
                      ),
                    ),
                    Gap(8.w),
                    Container(
                        padding: EdgeInsets.all(7.h),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: iconColor,
                          size: 10,
                        )),
                  ],
                )
              ],
            ),
          ),
          Positioned(top: 0, right: 0, child: ShowImage(image: backgroundImage))
        ]));
  }
}
