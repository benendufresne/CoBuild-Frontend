import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_regex.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Name textfield ,to show Name in complete app

class NameTextField extends StatelessWidget {
  final ValidatedController<StringValidation> controller;
  final FocusNode focusNode;
  final Function()? onTap;
  final bool isOnboarding;
  final String? hint;
  final int? maxLength;

  const NameTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      this.onTap,
      this.isOnboarding = false,
      this.hint,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return _nameTextField();
  }

  Widget _nameTextField() {
    return AppTextField(
      textInputAction: TextInputAction.next,
      maxLength: maxLength ?? AppConstant.nameMaxLimit,
      keyboardType: TextInputType.name,
      fillColor: isOnboarding ? onboardingTextFieldColor : null,
      hintText: "${hint ?? S.current.fullName}${S.current.requiredIcon}",
      inputFormatters: [
        FilteringTextInputFormatter.deny(AppRegex.emoji),
        // FilteringTextInputFormatter.deny('.'),
        // FilteringTextInputFormatter.deny(',')
      ],
      focusNode: focusNode,
      controller: controller,
      onTap: onTap,
    );
  }
}
