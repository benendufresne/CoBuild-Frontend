import 'package:cobuild/global/global.dart';
import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FAQTileShimmer extends StatelessWidget {
  final int itemCount;
  const FAQTileShimmer({super.key, required this.itemCount});

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
                  padding: EdgeInsets.all(10.r),
                  margin: EdgeInsets.only(
                      bottom: (index == itemCount - 1) ? 0 : 18.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shimmerCard(height: 12.h, width: deviceWidth * 0.7),
                            Gap(5.sp),
                            shimmerCard(
                                height: deviceHeight * 0.07,
                                width: deviceWidth * 0.7),
                          ],
                        ),
                      ),
                      Gap(15.sp),
                      shimmerCard(
                        height: 20.h,
                        width: 20.w,
                        shape: BoxShape.circle,
                      ),
                    ],
                  ),
                )));
  }
}
