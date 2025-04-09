import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_regex.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Email textfield ,to show Email in complete app

class EmailTextField extends StatelessWidget {
  final ValidatedController<StringValidation> controller;
  final FocusNode focusNode;
  final bool isRequired;
  final Function()? onTap;
  final bool isEnable;
  final bool isOnboarding;

  const EmailTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      this.isRequired = true,
      this.onTap,
      this.isEnable = true,
      this.isOnboarding = false});

  @override
  Widget build(BuildContext context) {
    return _emailTextField(context);
  }

  Widget _emailTextField(BuildContext context) {
    return AppTextField(
        textInputAction: TextInputAction.next,
        maxLength: AppConstant.emailMaxLimit,
        keyboardType: TextInputType.emailAddress,
        inputFormatters: [
          FilteringTextInputFormatter.deny(' '),
          FilteringTextInputFormatter.deny(AppRegex.emoji),
        ],
        onTap: onTap,
        fillColor: isOnboarding ? onboardingTextFieldColor : null,
        enabled: isEnable,
        hintText:
            "${S.current.emailAddress}${isRequired ? S.current.requiredIcon : ''}",
        focusNode: focusNode,
        controller: controller);
  }
}
