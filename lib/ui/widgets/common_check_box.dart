import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Common check box
class CommonCheckBox extends StatelessWidget {
  final void Function()? onTap;
  final bool? value;
  final void Function(bool?)? onChanged;
  const CommonCheckBox({
    super.key,
    this.onTap,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 42.sp,
        height: 42.sp,
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.primaryColor,
          hoverColor: AppColors.primaryColor,
          overlayColor: WidgetStateProperty.resolveWith((states) {
            return Colors.green;
          }),
          side: WidgetStateBorderSide.resolveWith(
            (states) =>
                const BorderSide(width: 1.0, color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class CheckBoxWithText extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool? value;
  final void Function(bool?)? onChanged;
  const CheckBoxWithText({
    super.key,
    required this.title,
    this.onTap,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: (bool? value) {
              onChanged!(value);
            },
            activeColor: AppColors.primaryColor,
            focusColor: AppColors.primaryColor,
            hoverColor: AppColors.primaryColor,
            overlayColor: WidgetStateProperty.resolveWith((states) {
              return Colors.green;
            }),
            side: WidgetStateBorderSide.resolveWith(
              (states) =>
                  const BorderSide(width: 1.0, color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Text(
                title,
                style: AppStyles().regularBold.colored(AppColors.blackText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
