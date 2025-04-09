import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text_fields/password_field.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// To reset user account password
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late AuthController controller;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    _clearAllInputFields();
  }

  void _clearAllInputFields() {
    controller.clearResetPasswordFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
          padding: KEdgeInsets.k(h: pageHorizontalPadding),
          child: Column(
            children: [
              ShowImage(
                  image: AppImages.resetPassword, height: 60.sp, width: 60.sp),
              Gap(20.h),
              Header2(heading: S.current.resetPassword),
              Gap(8.h),
              Title1(title: S.current.resetPassDescription),
              Gap(fieldGap),
              PasswordField(
                controller: controller.resetPasswordController,
                focusNode: controller.resetPasswordFocus,
                label: S.current.newPassword,
                onTap: () => onTapTextfield(globalKey),
                isOnboarding: true,
              ),
              Gap(fieldGap),
              PasswordField(
                controller: controller.resetConfirmPasswordController,
                focusNode: controller.resetConfirmPasswordFocus,
                label: S.current.confirmPassword,
                previouspasswordToMatch: controller.resetPasswordController,
                showPasswordHint: false,
                onTap: () => onTapTextfield(globalKey),
                isOnboarding: true,
              ),
              _continueButton(),
            ],
          )),
    );
  }

  Widget _continueButton() {
    return Column(
      key: globalKey,
      children: [
        Gap(30.h),
        BlocBuilderNew<AuthController, AuthState>(
            onSuccess: (authState) {
              if (authState.event is ResetPasswordEvent) {
                _showSuccessDialog();
              }
            },
            defaultView: (authState) => AppCommonButton(
                buttonName: S.current.submit,
                isExpanded: true,
                isLoading: (authState.state == BlocState.loading &&
                    authState.event is ResetPasswordEvent),
                validations: [
                  controller.resetPasswordController,
                  controller.resetConfirmPasswordController
                ],
                onPressed: () {
                  controller.add(ResetPasswordEvent(
                      model: controller.getResetPasswordModel()));
                })),
        Gap(majorGap)
      ],
    );
  }

  void _showSuccessDialog() {
    DialogBox().successDialog(
        subtitle: S.current.yourPasswordHasBeenSuccessfullyCreated,
        onTap: () {
          context.goNamed(AppRoutes.login);
        });
  }
}
