import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Dot to show new notification indicator
class NotificationIndicatorDot extends StatelessWidget {
  const NotificationIndicatorDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: 10.h,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.appBackGroundColor),
          color: AppColors.errorTextFieldColor,
          borderRadius: BorderRadius.circular(10.h)),
    );
  }
}
