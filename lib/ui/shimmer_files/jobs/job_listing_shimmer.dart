import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JobListingShimmer extends StatelessWidget {
  final int itemCount;
  const JobListingShimmer({super.key, required this.itemCount});

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
                  padding: EdgeInsets.only(top: 14.h, bottom: 14.h, left: 14.w),
                  margin: EdgeInsets.only(
                      bottom: (index == itemCount - 1) ? 0 : 18.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerCard(
                            radius: 8.r,
                            height: 38.h,
                            width: 38.h,
                            shape: BoxShape.rectangle,
                          ),
                          Gap(12.w),
                          Column(
                            children: [
                              shimmerCard(
                                height: 15.h,
                                width: 38.h,
                                shape: BoxShape.rectangle,
                              ),
                              Gap(3.h),
                              shimmerCard(
                                height: 18.h,
                                width: 38.h,
                                shape: BoxShape.rectangle,
                              ),
                            ],
                          ),
                          const Spacer(),
                          shimmerCard(
                            radius: 8.r,
                            height: 24.h,
                            width: 64.h,
                            shape: BoxShape.rectangle,
                          ),
                        ],
                      ),
                      Gap(15.h),
                      Row(
                        children: [
                          shimmerCard(
                            height: 24.h,
                            width: 17.w,
                            shape: BoxShape.rectangle,
                          ),
                          Gap(8.w),
                          shimmerCard(
                            height: 20.h,
                            width: 100.w,
                            shape: BoxShape.rectangle,
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 14.w),
                            child: shimmerCard(
                              height: 20.h,
                              width: 100.w,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )));
  }
}
