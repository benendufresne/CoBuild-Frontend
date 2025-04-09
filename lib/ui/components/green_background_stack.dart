import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Common green background stack used in profile page
class GreenBackgroundStack extends StatelessWidget {
  final double? height;
  final Widget child;
  const GreenBackgroundStack({super.key, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: height ?? 230.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r)),
        ),
      ),
      child
    ]);
  }
}
