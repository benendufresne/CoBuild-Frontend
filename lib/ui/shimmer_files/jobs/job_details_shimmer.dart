import 'package:cobuild/global/global.dart';
import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JobDetailsShimmer extends StatelessWidget {
  const JobDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                shimmerCard(height: 38.h, width: 38.h, radius: 8.r),
                Gap(12.w),
                shimmerCard(height: 20, width: 100.w),
              ],
            ),
            Gap(14.h),
            shimmerCard(width: 150.w, height: 25.h),
            Gap(12.h),
            _headline(),
            Gap(24.h),
            _headline(),
            Gap(10.h),
            _description(),
            Gap(20.h),
            _headline(),
            Gap(10.h),
            Row(
              children: [
                Expanded(child: _keyValueData()),
                Expanded(child: _keyValueData())
              ],
            ),
            Gap(10.h),
            _keyValueData(),
            Gap(20.h),
            _headline(),
            Gap(10.h),
            _keyValueData(),
            Gap(20.h),
            _headline(),
            Gap(10.h),
            Row(
              children: [
                Expanded(child: _keyValueData()),
                Expanded(child: _keyValueData())
              ],
            ),
            Gap(10.h),
            _keyValueData(),
            Gap(20.h),
            _headline(),
            Gap(10.h),
            shimmerCard(width: deviceWidth * 0.45, height: deviceHeight * 0.2),
            Gap(20.h),
            _headline(),
            Gap(10.h),
            _description(),
            Gap(20.h),
            _headline(),
            Gap(10.h),
            _keyValueData(),
            Gap(20.h),
            shimmerCard(height: 54.h, width: deviceWidth),
            Gap(20.h),
          ],
        ));
  }

  Widget _headline() {
    return shimmerCard(width: 250.w, height: 15.h);
  }

  Widget _description() {
    return shimmerCard(width: deviceWidth, height: 100.h);
  }

  Widget _keyValueData() {
    return Row(
      children: [
        shimmerCard(width: 24.w, height: 24.h, radius: 5),
        Gap(8.w),
        shimmerCard(width: 100.w, height: 15.h)
      ],
    );
  }
}
