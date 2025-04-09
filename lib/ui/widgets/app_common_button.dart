import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Common button used in complete app
class AppCommonButton extends StatelessWidget {
  final String buttonName;
  final Color? buttonColor;
  final Color? borderColor;
  final void Function() onPressed;
  final bool isEnable;
  final bool isBordered;
  final bool isLoading;
  final bool useDynamicHeight;
  final EdgeInsetsGeometry? padding;
  final bool isExpanded;
  final Widget? icon;
  final Color textColor;
  final double radius;
  final double? height;
  final double verticalPadding;
  final TextStyle? style;
  final List<BaseValidator<dynamic, Validation<dynamic>>>? validations;

  const AppCommonButton(
      {super.key,
      this.borderColor,
      this.useDynamicHeight = false,
      required this.buttonName,
      required this.onPressed,
      this.buttonColor,
      this.isEnable = true,
      this.isBordered = false,
      this.isLoading = false,
      this.icon,
      this.radius = 10,
      this.isExpanded = false,
      this.height,
      this.padding,
      this.validations,
      this.textColor = AppColors.white,
      this.verticalPadding = 15,
      this.style});

  @override
  Widget build(BuildContext context) {
    return ValidatedBuilder(
        key: UniqueKey(),
        validations: validations ?? [],
        builder: (context, error, validate) {
          return ListenableBuilder(
              listenable: Listenable.merge(
                  validations?.map((e) => e.listenable).toList() ?? []),
              builder: (context, _) {
                bool isButtonEnabled = shouldEnableButton;
                return InkWell(
                  onTap: isButtonEnabled ? onPressed : null,
                  child: Container(
                      width: isExpanded ? deviceWidth : null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                          color:
                              borderColor ?? AppColors.white.withOpacity(0.12),
                        ),
                        color: getButtonColor,
                      ),
                      child: Padding(
                          padding: padding ??
                              KEdgeInsets.k(
                                  h: isExpanded ? 0.w : 8.w,
                                  v: verticalPadding.h),
                          child:
                              isLoading ? _showLoader() : _showText(context))),
                );
              });
        });
  }

  bool get shouldEnableButton {
    // Check if any field is empty
    var isAnyTextEmpty = validations
            ?.whereType<ValidatedController>()
            .any((e) => e.text.isEmpty) ??
        false;

    // Ensure all fields pass validation or isEnable true
    var areAllFieldsValid = isNotBlank(validations)
        ? validations?.every((validator) => validator.error.isCorrect) ?? false
        : isEnable;

    // Enable the button only if no fields are empty and all validations pass or isEnable true and not loading
    var shouldEnableButton = !isAnyTextEmpty && areAllFieldsValid && !isLoading;
    return shouldEnableButton;
  }

  Color get getButtonColor {
    return (!shouldEnableButton && !isLoading)
        ? AppColors.disabledButtonColor
        : (buttonColor ?? AppColors.buttonColor);
  }

  Widget _showLoader() {
    return const CommonLoader(isButtonLoader: true);
  }

  Widget _showText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon ?? const SizedBox(),
          Gap(8.w),
        ],
        Text(buttonName,
            style: style ??
                AppStyles.of(context).buttonText.colored(shouldEnableButton
                    ? textColor
                    : AppColors.disableButtonTextColor)),
      ],
    );
  }
}
