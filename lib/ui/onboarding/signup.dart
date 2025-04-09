import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/ui/components/text/header1.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text_fields/email_text_field.dart';
import 'package:cobuild/ui/components/text_fields/password_field.dart';
import 'package:cobuild/ui/components/text_fields/phone_text_field.dart';
import 'package:cobuild/ui/onboarding/background_pattern.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/ui/widgets/common_check_box.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Signup to initial profile creation
class SignupPage extends StatefulWidget {
  final String? socialLoginId;
  const SignupPage({super.key, this.socialLoginId});

  @override
  State<StatefulWidget> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  late AuthController controller;
  late AuthStateStore state;
  GlobalKey globalKey = GlobalKey();
  bool showPassswordField = true;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    _clearAllInputFields();
    _checkIfSocialLogin();
    state = controller.state.stateStore;
  }

  void _checkIfSocialLogin() {
    if (widget.socialLoginId != null) {
      showPassswordField = false;
    }
  }

  void _clearAllInputFields() {
    controller.clearSignupFields();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    printCustom("nameis ${AppPreferences.name}");
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          padding: KEdgeInsets.k(h: pageHorizontalPadding),
          child: _bodyOfPage(),
        ).topRightLogo);
  }

  ///body view -----------------------------------------
  Widget _bodyOfPage() {
    return BlocBuilderNew<AuthController, AuthState>(
      onSuccess: (authState) {
        if (authState.event is SendSignupOtpEvent) {
          context.pushNamed(AppRoutes.verifyOtp,
              extra: controller.getVerifyOtpSignupModel());
        }
      },
      defaultView: (authState) => Column(children: [
        Gap(gapFromTopToShowPattern),
        ShowImage(image: AppImages.logo, height: 52.h, width: 44.w),
        Gap(12.h),
        Header1(heading: S.current.getStartedNow),
        Gap(8.h),
        Padding(
          padding: KEdgeInsets.k(h: 20.w),
          child: Title1(title: S.current.createAccountOrLogin),
        ),
        Gap(majorGapVertical),
        EmailTextField(
          controller: controller.signupEmailController,
          focusNode: controller.signupEmailFocus,
          onTap: () => onTapTextfield(globalKey),
          isOnboarding: true,
        ),
        Gap(fieldGap),
        PhoneTextField(
          controller: controller.signupPhoneController,
          focusNode: controller.signupPhoneFocus,
          countryCodeController: controller.signupCountrycode,
          onTap: () => onTapTextfield(globalKey),
          isOnboarding: true,
        ),
        if (showPassswordField) ...[
          Gap(fieldGap),
          PasswordField(
            controller: controller.signupPasswordController,
            focusNode: controller.signupPasswordFocus,
            onTap: () => onTapTextfield(globalKey),
            isOnboarding: true,
          )
        ],
        _acceptTermsAndConditions(),
        Gap(22.h),
        _continueButton(authState),
        AppRichText(children: [
          AppTextSpan(
              text: S.current.alreadyHaveAnAccount,
              style: AppStyles().smallSemiBold.colored(AppColors.greyText)),
          AppTextSpan(
              text: " ${S.current.login}",
              style:
                  AppStyles().sSmallSemiBlock.colored(AppColors.primaryColor),
              gesture: TapGestureRecognizerFactoryController((tap) {
                tap.onTap = () {
                  context.goNamed(AppRoutes.login);
                };
              })),
        ]),
        // Gap(22.h),
        // const SocialLoginOptions(),
        Gap(40.h),
      ]),
    );
  }

  Widget _acceptTermsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
            valueListenable: state.acceptTermAndConditions,
            builder: (context, value, widget) {
              return CommonCheckBox(
                  value: state.acceptTermAndConditions.value,
                  onChanged: (value) {
                    state.acceptTermAndConditions.value = value ?? false;
                  });
            }),
        Flexible(
          child: Padding(
            padding: KEdgeInsets.kOnly(t: 10.h),
            child: AppRichText(alignment: TextAlign.start, children: [
              AppTextSpan(
                text: '${S.current.byAggreeingTerms} ',
                style: AppStyles().smallRegular.colored(AppColors.greyText),
              ),
              AppTextSpan(
                gesture: TapGestureRecognizerFactoryController((tap) {
                  tap.onTap = () async {
                    await context.pushNamed(AppRoutes.staticContentPage,
                        extra: StaticContentEnum.tAndC);
                    unfocusTextField();
                  };
                }),
                text: S.current.userAgreement,
                style: AppStyles()
                    .smallSemiBold
                    .colored(AppColors.primaryColor)
                    .fdUnderlined,
              ),
              AppTextSpan(
                text: ' ${S.current.and} ',
                style: AppStyles().smallRegular.colored(AppColors.greyText),
              ),
              AppTextSpan(
                gesture: TapGestureRecognizerFactoryController((tap) {
                  tap.onTap = () async {
                    await context.pushNamed(AppRoutes.staticContentPage,
                        extra: StaticContentEnum.privacyPolicy);
                    unfocusTextField();
                  };
                }),
                text: "${S.current.privacyPolicy}.",
                style: AppStyles()
                    .smallSemiBold
                    .colored(AppColors.primaryColor)
                    .fdUnderlined,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _continueButton(AuthState authState) {
    return Padding(
      key: globalKey,
      padding: KEdgeInsets.kOnly(b: 22.h),
      child: AppCommonButton(
          buttonName: S.current.getStarted,
          isExpanded: true,
          validations: validationsList,
          isLoading: (authState.event is SendSignupOtpEvent &&
              authState.state == BlocState.loading),
          onPressed: () {
            if (!controller.state.stateStore.acceptTermAndConditions.value) {
              showSnackBar(
                message: S.current.acceptUserAggreementAndPrivacyPolcicy,
              );
            } else {
              controller.add(SendSignupOtpEvent(
                  model: controller.getSignupModel(
                      socialId: widget.socialLoginId)));
            }
          }),
    );
  }

  List<BaseValidator<dynamic, Validation<dynamic>>>? get validationsList {
    List<BaseValidator<dynamic, Validation<dynamic>>>? validations = [
      controller.signupEmailController,
      controller.signupPhoneController
    ];
    if (showPassswordField) {
      validations.add(controller.signupPasswordController);
    }
    return validations;
  }
}
