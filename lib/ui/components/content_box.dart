import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Common content box
class ContentBox extends StatelessWidget {
  final Widget child;
  const ContentBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: KEdgeInsets.k16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: AppColors.white),
      child: child,
    );
  }
}
