import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

class Header2 extends StatelessWidget {
  final String heading;
  final int fontSize;
  final Color color;
  const Header2(
      {super.key,
      required this.heading,
      this.fontSize = 22,
      this.color = AppColors.blackText});

  @override
  Widget build(BuildContext context) {
    return Text(heading,
        style: AppStyles()
            .sExtraLargeBolder
            .colored(color)
            .copyWith(fontSize: fontSize.sp));
  }
}
