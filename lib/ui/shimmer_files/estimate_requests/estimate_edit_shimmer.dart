import 'package:cobuild/global/global.dart';
import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EstimateEditShimmer extends StatelessWidget {
  const EstimateEditShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textField,
            Gap(16.h),
            _textField,
            Gap(16.h),
            _textField,
            Gap(16.h),
            _textField,
            Gap(16.h),
            _textField,
            Gap(16.h),
            shimmerCard(height: 150.h, width: deviceWidth, radius: 8.r),
            Gap(16.h),
            shimmerCard(height: 200.h, width: deviceWidth, radius: 8.r),
          ],
        ));
  }

  Widget get _textField {
    return shimmerCard(height: 54.h, width: deviceWidth, radius: 8.r);
  }
}
