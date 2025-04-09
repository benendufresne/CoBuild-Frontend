import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/onboarding/components/password_format.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Password textfield ,to show Password in complete app

class PasswordField extends StatefulWidget {
  final String? label;
  final ValidatedController<StringValidation> controller;
  final ValidatedController<StringValidation>? previouspasswordToMatch;
  final FocusNode focusNode;
  final bool isRequired;
  final bool showPasswordHint;
  final Function()? onTap;
  final bool isOnboarding;

  const PasswordField(
      {super.key,
      required this.controller,
      this.previouspasswordToMatch,
      required this.focusNode,
      this.label,
      this.isRequired = true,
      this.showPasswordHint = true,
      this.onTap,
      this.isOnboarding = false});
  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return _passwordTextField();
  }

  Widget _passwordTextField() {
    return Column(
      children: [
        AppTextField(
            textInputAction: TextInputAction.next,
            maxLength: AppConstant.passwordMaxLength,
            keyboardType: TextInputType.text,
            obscureText: !showPassword,
            onTap: widget.onTap,
            fillColor: widget.isOnboarding ? onboardingTextFieldColor : null,
            onChange: (val) {
              setState(() {});
            },
            suffixIcon: Padding(
              padding: EdgeInsets.all(16.h),
              child: InkWell(
                splashColor: AppColors.transparent,
                onTap: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                child: ShowImage(
                  image: showPassword
                      ? AppImages.passwordShow
                      : AppImages.passwordHide,
                  height: 18.h,
                  color: (widget.focusNode.hasFocus ||
                          widget.controller.text.isNotEmpty)
                      ? AppColors.primaryColor
                      : AppColors.lavenderGray,
                  width: 18.w,
                ),
              ),
            ),
            maxLines: 1,
            hintText:
                "${widget.label ?? S.current.password}${widget.isRequired ? S.current.requiredIcon : ''}",
            focusNode: widget.focusNode,
            controller: widget.controller),
        if (widget.showPasswordHint) ...[
          Gap(6.h),
          const PasswordFormat(),
        ]
      ],
    );
  }
}
