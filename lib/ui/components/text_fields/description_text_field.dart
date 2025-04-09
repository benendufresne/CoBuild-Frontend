import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';

/// Description textfield ,to show Description in complete app

class DescriptionTextField extends StatelessWidget {
  final ValidatedController<StringValidation> controller;
  final FocusNode focusNode;
  final String? hint;
  final Function()? onTap;
  final bool isOnboarding;
  final int maxLength;

  const DescriptionTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      this.onTap,
      this.hint,
      this.isOnboarding = false,
      required this.maxLength});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      textInputAction: TextInputAction.newline,
      maxLength: maxLength,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      fillColor: isOnboarding ? onboardingTextFieldColor : null,
      hintText: "${hint ?? S.current.description}${S.current.requiredIcon}",
      // inputFormatters: [
      //   FilteringTextInputFormatter.deny('.'),
      //   FilteringTextInputFormatter.deny(',')
      // ],
      focusNode: focusNode,
      isCounter: true,
      controller: controller,
      onTap: onTap,
    );
  }
}
