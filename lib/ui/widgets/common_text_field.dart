import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Common text field used in complete app
class AppTextField extends StatelessWidget {
  final String hintText;
  final String? label;
  final Widget? prefixWidget;
  final Function(String)? onChange;
  final void Function()? onEditingComplete;
  final ValidatedController controller;
  final Widget? suffixWidget;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final FocusNode? nextFocusNode;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool isCounter;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintstyleColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final bool isLableRequired;
  final String? suffixText;
  final double? radius;
  final double? lableGap;
  final TextStyle? labelStyle;
  final bool requiredField;
  final bool autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool isDropDwon;

  const AppTextField(
      {super.key,
      this.onTap,
      this.autoFocus = false,
      this.lableGap,
      required this.hintText,
      required this.controller,
      this.label,
      this.onChange,
      this.isCounter = false,
      this.focusNode,
      this.onEditingComplete,
      this.suffixWidget,
      this.prefixWidget,
      this.keyboardType,
      this.textInputAction,
      this.maxLines,
      this.nextFocusNode,
      this.maxLength,
      this.readOnly = false,
      this.suffixIcon,
      this.fillColor,
      this.borderColor,
      this.hintstyleColor,
      this.enabled = true,
      this.isLableRequired = true,
      this.inputFormatters,
      this.suffixText,
      this.labelStyle,
      this.radius,
      this.contentPadding,
      this.textCapitalization = TextCapitalization.none,
      this.requiredField = true,
      this.obscureText = false,
      this.isDropDwon = false});

  @override
  Widget build(BuildContext context) {
    return ValidationBuilder(
      controller: controller,
      builder: (context, error) {
        return AnimatedBuilder(
          animation: controller.focusNode,
          builder: (context, _) {
            var hintStyle = AppStyles.of(context)
                .sRegular
                .wSemiBold
                .colored(hintstyleColor ?? AppColors.hintTextColor);
            var commonBorder =
                controller.text.isNotEmpty && isNotBlank(error.errorString)
                    ? errorBorder(radius: radius)
                    : createBorder(borderColor ?? AppColors.textfieldBorder,
                        radius: radius);
            var focusBorder =
                (controller.text.isNotEmpty && isNotBlank(error.errorString))
                    ? errorBorder(radius: radius)
                    : createBorder(borderColor ?? AppColors.primaryColor,
                        radius: radius);
            bool showLabel =
                (controller.focusNode.hasFocus || controller.text.isNotEmpty) &&
                    isLableRequired;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showLabel)
                    Padding(
                      padding: KEdgeInsets.kOnly(b: 4.h),
                      child: Text(label ?? hintText,
                          style: AppStyles().smallSemiBold.colored(
                              (enabled || isDropDwon)
                                  ? AppColors.textLabelColor
                                  : AppColors.greyText)),
                    ),
                  TextField(
                    autofocus: autoFocus,
                    onTap: onTap,
                    readOnly: readOnly,
                    inputFormatters: inputFormatters,
                    maxLength: maxLength,
                    maxLines: maxLines,
                    textInputAction: textInputAction ?? TextInputAction.next,
                    keyboardType: keyboardType,
                    cursorColor: AppColors.black,
                    controller: controller.controller,
                    obscureText: obscureText,
                    obscuringCharacter: '*',
                    onTapOutside: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    onEditingComplete: onEditingComplete,
                    style: AppStyles.of(context).textField.colored(
                        (enabled || isDropDwon)
                            ? null
                            : AppColors.errorBlack.withOpacity(0.4)),
                    onChanged: onChange,
                    focusNode: controller.focusNode,
                    textCapitalization: textCapitalization,
                    enabled: enabled,
                    decoration: InputDecoration(
                        suffixText: suffixText,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: fillColor ?? AppColors.white,
                        filled: true,
                        counterText: isCounter ? null : "",
                        counterStyle: AppStyles.of(context)
                            .sSmall
                            .sRegular
                            .colored(AppColors.greyText),
                        hintText: hintText,
                        errorMaxLines: 3,
                        prefixIcon: prefixWidget,
                        suffix: suffixWidget,
                        suffixIcon: suffixIcon,
                        contentPadding:
                            KEdgeInsets.kOnly(l: 14.w, t: 15.h, b: 15.h),
                        errorText: error.errorString,
                        hintStyle: hintStyle,
                        errorStyle: AppStyles.of(context).textFieldError,
                        focusedErrorBorder: errorBorder(),
                        border: commonBorder,
                        errorBorder: errorBorder(),
                        enabledBorder: commonBorder,
                        focusedBorder: focusBorder,
                        disabledBorder: disabledBorder()),
                  )
                ]);
          },
        );
      },
    );
  }

  OutlineInputBorder createBorder(Color color, {double? radius}) {
    return OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius ?? 8.0.r),
      borderSide: BorderSide(color: color, width: 1.w),
    );
  }

  OutlineInputBorder errorBorder({double? radius}) {
    return OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius ?? 8.0.r),
      borderSide: BorderSide(color: AppColors.errorTextFieldColor, width: 1.w),
    );
  }

  InputBorder disabledBorder({double? radius}) {
    return OutlineInputBorder(
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius ?? 8.0.r),
      borderSide: BorderSide(color: AppColors.textfieldBorder, width: 1.w),
    );
  }
}
