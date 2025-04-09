import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EstimateListingShimmer extends StatelessWidget {
  final int itemCount;
  const EstimateListingShimmer({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: ListView.builder(
            itemCount: itemCount,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.errorTextFieldColor),
                      borderRadius: BorderRadius.circular(16.r)),
                  padding: KEdgeInsets.k12,
                  margin: EdgeInsets.only(
                      bottom: (index == itemCount - 1) ? 0 : 15.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image
                      shimmerCard(height: 100.h, width: 100.h, radius: 8.r),
                      Gap(16.w),
                      // Data
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerCard(height: 20.h, width: 160.w, radius: 8.r),
                          Gap(7.h),
                          shimmerCard(height: 16.h, width: 98.w, radius: 8.r),
                          Gap(7.h),
                          shimmerCard(height: 16.h, width: 150.w, radius: 8.r),
                          Gap(12.h),
                          shimmerCard(width: 60.w, height: 22.h)
                        ],
                      ),
                      const Spacer(),
                      // Popup option
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Column(
                          children: [
                            shimmerCard(height: 6, width: 6),
                            Gap(2.h),
                            shimmerCard(height: 6, width: 6),
                            Gap(2.h),
                            shimmerCard(height: 6, width: 6),
                          ],
                        ),
                      )
                    ],
                  ),
                )));
  }
}
