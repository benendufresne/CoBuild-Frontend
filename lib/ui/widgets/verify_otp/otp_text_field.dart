import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_regex.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

/// Text field :- used to verify OTP
class OTPTextField extends StatelessWidget {
  final String? errorMessage;
  final int? length;
  final Color? borderColor;
  final Color? fillColor;
  final TextEditingController otpController;
  final double? gap;
  final TextInputType? keyboardType;
  final FocusNode otpFocusNode = FocusNode();
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final double textFieldHeight = 50.h;
  OTPTextField(
      {super.key,
      required this.otpController,
      this.errorMessage,
      this.length,
      this.gap,
      this.fillColor,
      this.inputFormatters,
      this.onChanged,
      this.borderColor,
      this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return _newOtpField(context);
  }

  _newOtpField(BuildContext context) {
    return Pinput(
      controller: otpController,
      //focusNode: otpFocusNode,
      autofocus: true,
      length: length ?? 6,
      preFilledWidget: Text(
        '-',
        style: AppStyles().mediumRegular,
      ),
      errorText: (errorMessage?.isNotEmpty ?? false) ? errorMessage : null,
      errorTextStyle: AppStyles.of(context).textFieldError,
      forceErrorState: (errorMessage?.isNotEmpty ?? false),
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.allow(
              AppRegex.numberOnlyFilter,
            ),
          ],
      errorPinTheme: defaultPinTheme(context).copyWith(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.errorTextFieldColor),
      )),
      onChanged: onChanged ??
          (value) {
            if (value.length == (length ?? 6)) {
              FocusScope.of(context).unfocus();
            }
          },
      submittedPinTheme: focusedPinTheme(context),
      focusedPinTheme: focusedPinTheme(context),
      defaultPinTheme: defaultPinTheme(context),
      separatorBuilder: (index) => SizedBox(width: gap ?? 8),
      hapticFeedbackType: HapticFeedbackType.lightImpact,
    );
  }

  defaultPinTheme(BuildContext context) => PinTheme(
        width: textFieldHeight,
        height: textFieldHeight,
        textStyle: AppStyles.of(context).regularBolder,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.auroMetalSaurus),
        ),
      );

  focusedPinTheme(BuildContext context) => PinTheme(
        width: textFieldHeight,
        height: textFieldHeight,
        textStyle: AppStyles.of(context).regularBolder,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: borderColor ?? AppColors.primaryColor),
        ),
      );
}
