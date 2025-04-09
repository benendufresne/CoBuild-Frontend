import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_back_button.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Common Error page used in app
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        leading: const AppCommonBackButton(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: AppCommonButton(
            buttonName: "Something went wrong",
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
