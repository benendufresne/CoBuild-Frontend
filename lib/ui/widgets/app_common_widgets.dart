import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Common divider used in app
class AppCommonDivider extends StatelessWidget {
  final Color? color;
  const AppCommonDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color ?? AppColors.darkGreyText),
      ),
    );
  }
}
