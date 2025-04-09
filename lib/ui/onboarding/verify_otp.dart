import 'dart:async';
import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_bloc.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_event.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/onboarding/verify_otp_api_model/verify_otp_api_model.dart';
import 'package:cobuild/models/verify_otp_model/verify_otp_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/ui/widgets/verify_otp/otp_text_field.dart';
import 'package:cobuild/ui/widgets/verify_otp/verify_otp_components.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/onboarding_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Verify otp screen
class VerifyOtpScreen extends StatefulWidget {
  final VerifyOtpModel? model;
  const VerifyOtpScreen({super.key, required this.model});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  ScrollController controller = ScrollController();
  Timer? countdownTimer;
  Duration resendDuration = const Duration(minutes: 1);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  bool showError = false;
  String errorMessage = '';
  late VerifyOtpController otpBloc;

  @override
  void initState() {
    otpBloc = context.read<VerifyOtpController>();
    _clearInputField();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        startTimer();
      }
    });
    super.initState();
  }

  void _clearInputField() {
    otpBloc.clearOtpField();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  /// Timer related methods -----------------------------------------
  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setCountDown();
      }
    });
  }

  /// stop timer -----------------------------------------
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  /// reset timer -----------------------------------------
  void resetTimer() {
    stopTimer();
    setState(() => resendDuration = const Duration(minutes: 1));
    startTimer();
  }

  ///set count down -----------------------------------------
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = resendDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        resendDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.hasClients) {
      VerifyOtpComponents.keyboardOptimisation(controller, keyboardHeight);
    }
    return Scaffold(
      appBar: CommonAppBar.appBar(),
      backgroundColor: AppColors.white,
      body: BlocBuilderNew<VerifyOtpController, VerifyOtpState>(
        defaultView: _bodyOfPage,
        onSuccess: (blocEventState) {
          if (blocEventState.event is VerifyOtpEvent) {
            VerifyOtpEvent response = blocEventState.event as VerifyOtpEvent;
            if (response.model.type ==
                VerifyOtpEnum.signupEmail.getBackendEnum) {
              _showEmailVerifiedlDialogOnSignup();
            } else if (response.model.type ==
                VerifyOtpEnum.forgotPassword.getBackendEnum) {
              _navigateToResetPasswordPage();
            }
          } else if (blocEventState.event is ResendOtpEvent) {
            resetTimer();
            if ((blocEventState.response?.data != null &&
                blocEventState.response?.data[ApiKeys.message] != null)) {
              showSnackBar(
                  message: blocEventState.response?.data[ApiKeys.message] ?? '',
                  isSuccess: true);
            }
          }
        },
        onFailed: (blocEvent) {
          if ((blocEvent.event is VerifyOtpEvent) &&
              (blocEvent.response?.data != null &&
                  blocEvent.response?.data['type'] == 'INVALID_OTP')) {
            showError = true;
            errorMessage = blocEvent.response?.message ?? "";
          }
        },
      ),
    );
  }

  /// body of page -----------------------------------------
  Widget _bodyOfPage(VerifyOtpState blocEventState) {
    final minutes = strDigits(resendDuration.inMinutes.remainder(60));
    final seconds = strDigits(resendDuration.inSeconds.remainder(60));
    final timeOut = minutes == '00' && seconds == '00';
    return Padding(
      padding: KEdgeInsets.k(h: pageHorizontalPadding),
      child: Column(
        children: [
          Gap(12.h),
          ShowImage(
            image: AppImages.verifyOTP,
            height: 60.sp,
            width: 60.sp,
          ),
          Gap(10.h),
          Header2(
            heading: S.current.verifyYourEmail,
          ),
          Gap(8.h),
          AppRichText(alignment: TextAlign.center, children: [
            AppTextSpan(
                text: S.current.aVerificationCodeHasBeenSent,
                style: AppStyles().regularSemiBold.colored(AppColors.greyText)),
            AppTextSpan(
              text: widget.model?.email ?? '',
              style: AppStyles().regularBolder.colored(AppColors.blackText),
            ),
          ]),
          Gap(majorGap),
          OTPTextField(
            otpController: otpBloc.state.otpController,
            errorMessage: errorMessage,
            onChanged: (value) {
              setState(() {
                showError = false;
                errorMessage = '';
              });
              if (value.length == 6) {
                FocusScope.of(context).unfocus();
                _verifyOtp();
              }
            },
          ),
          Gap(36.h),
          if (timeOut) ...[
            AppRichText(alignment: TextAlign.center, children: [
              AppTextSpan(
                  text: S.current.didntGetCode,
                  style:
                      AppStyles().regularSemiBold.colored(AppColors.greyText)),
              AppTextSpan(
                gesture: TapGestureRecognizerFactoryController((tap) {
                  tap.onTap =
                      (blocEventState.state.isLoading) ? () {} : _resendOtp;
                }),
                text: S.current.resendOtp,
                style:
                    AppStyles().regularBolder.colored(AppColors.primaryColor),
              ),
            ])
          ],
          if (!timeOut)
            AppRichText(alignment: TextAlign.center, children: [
              AppTextSpan(
                  text: S.current.resendOtpIn,
                  style:
                      AppStyles().regularSemiBold.colored(AppColors.greyText)),
              AppTextSpan(
                text: '$minutes:$seconds',
                style:
                    AppStyles().regularBolder.colored(AppColors.primaryColor),
              ),
            ]),
          Gap(57.h),
          AppCommonButton(
              isExpanded: true,
              buttonName: S.current.submit,
              isEnable: otpBloc.state.otpController.text.length == 6,
              isLoading: (blocEventState.state.isLoading &&
                  blocEventState.event is VerifyOtpEvent),
              onPressed: () {
                if (otpBloc.state.otpController.text.length == 6) {
                  _verifyOtp();
                }
              }),
        ],
      ),
    );
  }

  /// resend otp -----------------------------------------
  _resendOtp() {
    switch (widget.model?.type) {
      case VerifyOtpEnum.signupEmail:
      case VerifyOtpEnum.forgotPassword:
        _resendSignupOtpOnEmail();
      default:
    }
  }

  /// verify otp -----------------------------------------
  void _verifyOtp() {
    switch (widget.model?.type) {
      case VerifyOtpEnum.signupEmail:
      case VerifyOtpEnum.forgotPassword:
        _verifySignupEmailOtp();
      default:
    }
  }

  void _verifySignupEmailOtp() {
    otpBloc.add(VerifyOtpEvent(model: _verifyOtpModel));
  }

  void _resendSignupOtpOnEmail() {
    otpBloc.add(ResendOtpEvent(model: _resendOtpModel));
  }

  VerifyOtpApiModel get _verifyOtpModel => VerifyOtpApiModel(
        email: widget.model?.email ?? '',
        otp: otpBloc.state.otpController.text,
        type: widget.model?.type?.getBackendEnum,
      );

  VerifyOtpApiModel get _resendOtpModel => VerifyOtpApiModel(
        email: widget.model?.email ?? '',
        type: widget.model?.type?.getBackendEnum,
      );

  void _showEmailVerifiedlDialogOnSignup() {
    DialogBox().successDialog(
        subtitle: S.current.emailVerifiedSuccess,
        onTap: () {
          _navigateToCompleteProfilePage();
        });
  }

  void _navigateToCompleteProfilePage() {
    context.goNamed(AppRoutes.completeProfile);
  }

  void _navigateToResetPasswordPage() {
    context.pop();
    context.pushNamed(AppRoutes.resetPassword);
  }
}
