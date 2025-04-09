import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_back_button.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Under development widget to show if any feature is under development
class UnderDevelopment extends StatelessWidget {
  final bool showBackButton;
  const UnderDevelopment({this.showBackButton = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            showBackButton ? AppColors.primaryColor : AppColors.white,
        automaticallyImplyLeading: false,
        leading: showBackButton ? const AppCommonBackButton() : null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: AppCommonButton(
            buttonName: "Under Development",
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
