import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPageMessageListingShimmer extends StatelessWidget {
  final int itemCount;
  const ChatPageMessageListingShimmer({super.key, required this.itemCount});

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
            itemBuilder: (BuildContext context, int index) => Padding(
                  padding: KEdgeInsets.kOnly(b: 16.h),
                  child: Column(
                    crossAxisAlignment: (index % 2 == 0)
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 300.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.errorTextFieldColor),
                            borderRadius: BorderRadius.circular(16.r)),
                        child: shimmerCard(height: 40.h, radius: 8.r),
                      ),
                      Gap(5.h),
                      shimmerCard(height: 15.h, width: 80.w, radius: 8.r),
                    ],
                  ),
                )));
  }
}
