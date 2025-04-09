import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Common text styles used in app
class Header1 extends StatelessWidget {
  final String heading;
  final int fontSize;
  const Header1({super.key, required this.heading, this.fontSize = 28});

  @override
  Widget build(BuildContext context) {
    return Text(heading,
        style: AppStyles()
            .header1
            .colored(AppColors.blackText)
            .copyWith(fontSize: fontSize.sp));
  }
}
