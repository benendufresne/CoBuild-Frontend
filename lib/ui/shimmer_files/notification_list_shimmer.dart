import 'package:cobuild/global/global.dart';
import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationListingShimmer extends StatelessWidget {
  final int itemCount;
  const NotificationListingShimmer({super.key, required this.itemCount});

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
                  padding: KEdgeInsets.k(h: 10.w, v: 16.h),
                  margin: EdgeInsets.only(
                      bottom: (index == itemCount - 1) ? 0 : 16.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      shimmerCard(
                        radius: 20.r,
                        height: 40.h,
                        width: 40.h,
                        shape: BoxShape.rectangle,
                      ),
                      Gap(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerCard(
                            radius: 8.r,
                            height: 20.h,
                            width: deviceWidth * 0.3,
                          ),
                          Gap(4.h),
                          Row(
                            children: [
                              shimmerCard(
                                radius: 8.r,
                                height: 20.h,
                                width: deviceWidth * 0.5,
                              ),
                              Gap(8.w),
                              shimmerCard(
                                radius: 8.r,
                                height: 20.h,
                                width: deviceWidth * 0.15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )));
  }
}
