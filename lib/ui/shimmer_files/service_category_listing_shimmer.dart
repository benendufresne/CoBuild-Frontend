import 'package:cobuild/global/global.dart';
import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryServiceShimmer extends StatelessWidget {
  final int itemCount;
  const CategoryServiceShimmer({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: ListView.separated(
          itemCount: itemCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => SizedBox(height: 15.sp),
          itemBuilder: (BuildContext context, int index) =>
              shimmerCard(height: deviceHeight * .1, width: deviceWidth),
        ));
  }
}
