import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Common drop down type of text field , used multiple places in app
class DropDownTextField extends StatelessWidget {
  final ValidatedController<StringValidation> controller;
  final FocusNode focusNode;
  final bool isRequired;
  final Function() onTap;
  final bool isEnable;
  final String hintText;

  const DropDownTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.hintText,
      this.isRequired = true,
      required this.onTap,
      this.isEnable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () => onTap(),
      child: AppTextField(
          textInputAction: TextInputAction.next,
          suffixIcon: Padding(
            padding: EdgeInsets.all(16.h),
            child: ShowImage(
              image: AppImages.dropDownIcon,
              height: 18.h,
              color: AppColors.black,
              width: 18.w,
            ),
          ),
          enabled: isEnable,
          isDropDwon: true,
          hintText: "$hintText${isRequired ? S.current.requiredIcon : ''}",
          focusNode: focusNode,
          controller: controller),
    );
  }
}
