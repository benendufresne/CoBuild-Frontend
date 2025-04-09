import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Common radio button
class CommonRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String label;
  final TextStyle? labelStyle;
  final Color? activeColor;

  const CommonRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    this.labelStyle,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor ?? Theme.of(context).primaryColor,
          ),
          Title3(title: label, color: AppColors.blackText),
        ],
      ),
    );
  }
}
