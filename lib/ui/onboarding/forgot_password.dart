import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/onboarding/verify_otp_api_model/verify_otp_api_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/text/header1.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text_fields/email_text_field.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/enums/onboarding_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Forgot passord screen
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthController authController = AuthController();
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    authController = context.read<AuthController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearAllInputFields();
    });
  }

  void _clearAllInputFields() {
    authController.clearForgotPasswordFields();
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
            Gap(12.h),
            ShowImage(
              image: AppImages.forgotPassword,
              height: 60.sp,
              width: 60.sp,
            ),
            Gap(20.h),
            Header1(heading: S.current.forgotPassword, fontSize: 22),
            Gap(8.h),
            Title1(title: S.current.forgotPasswordDescription),
            Gap(majorGapVertical),
            EmailTextField(
              controller: authController.forgotPasswordEmailController,
              focusNode: authController.forgotPasswordEmailFocus,
              onTap: () => onTapTextfield(globalKey),
              isOnboarding: true,
            ),
            Gap(90.h),
            _submitButton()
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Column(
      key: globalKey,
      children: [
        BlocBuilderNew<AuthController, AuthState>(
            onSuccess: (authState) {
              if (authState.event is ForgotPasswordSendOTPEvent) {
                context.pushNamed(AppRoutes.verifyOtp,
                    extra: authController.getVerifyForgotPasswordModel());
              }
            },
            defaultView: (authState) => AppCommonButton(
                buttonName: S.current.submit,
                validations: [
                  authController.forgotPasswordEmailController,
                ],
                isLoading: (authState.event is ForgotPasswordSendOTPEvent &&
                    authState.state == BlocState.loading),
                isExpanded: true,
                onPressed: () {
                  authController.add(ForgotPasswordSendOTPEvent(
                    model: VerifyOtpApiModel(
                        type: VerifyOtpEnum.forgotPassword.getBackendEnum,
                        email: authController.forgotPasswordEmailController.text
                            .trim()),
                  ));
                })),
        Gap(majorGapVertical)
      ],
    );
  }
}
