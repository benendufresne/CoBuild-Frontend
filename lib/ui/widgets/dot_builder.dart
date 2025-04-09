import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Dot builder :- to indicate multipe items
class DotBuilder extends StatelessWidget {
  const DotBuilder({
    super.key,
    this.height,
    this.width,
    required this.length,
    this.color,
    this.isShapeChange = true,
    required this.currentIndex,
    this.isCircle = false,
  });

  final int length;
  final double? height;
  final double? width;
  final Color? color;
  final int currentIndex;
  final bool isShapeChange;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => buildDot(
          index,
        ),
      ),
    );
  }

  //  dot indicator.
  Widget buildDot(int index) {
    return Container(
        padding: KEdgeInsets.k(h: 2.w, v: 4.h),
        height: isCircle ? (isShapeChange ? 8.sp : height) : 4.h,
        width: isCircle ? (isShapeChange ? 8.sp : width) : 10,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isCircle
                ? (currentIndex == index
                    ? AppColors.primaryColor
                    : AppColors.grayTextColor.withOpacity(0.4))
                : (currentIndex == index
                    ? color ?? AppColors.primaryColor
                    : AppColors.grayTextColor.withOpacity(0.4))));
  }
}
