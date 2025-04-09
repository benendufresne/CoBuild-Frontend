import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

class Title2 extends StatelessWidget {
  final String title;
  final TextAlign align;
  final int fontSize;
  final Color color;
  const Title2(
      {super.key,
      required this.title,
      this.align = TextAlign.center,
      this.fontSize = 16,
      this.color = AppColors.greyText});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style:
            AppStyles().copyWith(color: color, fontSize: fontSize.sp).wRegular,
        textAlign: align);
  }
}
