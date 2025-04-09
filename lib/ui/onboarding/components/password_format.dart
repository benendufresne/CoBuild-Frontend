import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Password format :- hint for user
class PasswordFormat extends StatelessWidget {
  const PasswordFormat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: Text(
        AppConstant.passwordFormat,
        style: AppStyles().sExtraSmallwRegular.colored(AppColors.greyText),
      ),
    );
  }
}
