import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/ui/widgets/country_code_picker.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Phone number textfield ,to show Phone number in complete app

// ignore: must_be_immutable
class PhoneTextField extends StatelessWidget {
  final ValidatedController<StringValidation> controller;
  final FocusNode focusNode;
  CountryCode countryCodeController;
  final bool isRequired;
  final Function()? onTap;
  final bool isOnboarding;

  PhoneTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.countryCodeController,
    this.isRequired = true,
    this.onTap,
    this.isOnboarding = false,
  });

  @override
  Widget build(BuildContext context) {
    return _phoneTextField();
  }

  Widget _phoneTextField() {
    return AppTextField(
        textInputAction: TextInputAction.next,
        maxLength: AppConstant.phoneNumberMaxLimit,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onTap: onTap,
        fillColor: isOnboarding ? onboardingTextFieldColor : null,
        hintText:
            "${S.current.phoneNumber}${isRequired ? S.current.requiredIcon : ''}",
        focusNode: focusNode,
        prefixWidget: countryCodePicker(),
        controller: controller);
  }

  Widget countryCodePicker() {
    return CountryCodepickerWidget(
      onChange: (val) {
        countryCodeController = val;
      },
    );
  }
}
