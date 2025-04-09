import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isUnderLine;
  const LinkText(
      {super.key,
      required this.text,
      required this.onTap,
      this.isUnderLine = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Text(text,
          style: AppStyles().regularBold.copyWith(
              color: AppColors.primaryColor,
              decorationColor: AppColors.primaryColor,
              decoration: isUnderLine ? TextDecoration.underline : null)),
    );
  }
}
