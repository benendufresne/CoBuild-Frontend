import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/version_management/verion_management.dart';
import 'package:cobuild/ui/components/text/header1.dart';
import 'package:cobuild/ui/components/text/link_text.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text_fields/email_text_field.dart';
import 'package:cobuild/ui/components/text_fields/password_field.dart';
import 'package:cobuild/ui/onboarding/background_pattern.dart';
import 'package:cobuild/ui/onboarding/social_login_options.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// To login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late AuthController authController;
  GlobalKey globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    authController = context.read<AuthController>();
    _clearAllInputFields();
    _clearAppGlobalData();
    VersionManagement().checkAppVersion();
  }

  void _clearAllInputFields() {
    authController.clearLoginFields();
  }

  _clearAppGlobalData() {
    context.read<AppController>().add(ClearAllGlobalDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: KEdgeInsets.k(h: pageHorizontalPadding),
        child: _bodyOfPage(),
      ).topRightLogo,
    );
  }

  ///body view -----------------------------------------
  Widget _bodyOfPage() {
    return BlocBuilderNew<AuthController, AuthState>(
        defaultView: (authState) => Stack(
              children: [
                Column(
                  children: [
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
                      controller: authController.loginEmailController,
                      focusNode: authController.loginEmailFocus,
                      onTap: () => onTapTextfield(globalKey),
                      isOnboarding: true,
                    ),
                    Gap(fieldGap),
                    PasswordField(
                      controller: authController.loginPasswordController,
                      focusNode: authController.loginPasswordFocus,
                      onTap: () => onTapTextfield(globalKey),
                      showPasswordHint: false,
                      isOnboarding: true,
                    ),
                    Gap(fieldGap),
                    Align(
                        alignment: Alignment.topRight,
                        child: LinkText(
                            text: "${S.current.forgotPassword} ?",
                            onTap: () async {
                              await context.pushNamed(AppRoutes.forgotPassword);
                              unfocusTextField();
                            })),
                    _continueButton(authState),
                    AppRichText(children: [
                      AppTextSpan(
                          text: S.current.dontHaveAccount,
                          style: AppStyles()
                              .smallSemiBold
                              .colored(AppColors.greyText)),
                      AppTextSpan(
                          text: " ${S.current.signup}",
                          style: AppStyles()
                              .sSmallSemiBlock
                              .colored(AppColors.primaryColor),
                          gesture: TapGestureRecognizerFactoryController((tap) {
                            tap.onTap = () {
                              context.goNamed(AppRoutes.signup);
                            };
                          })),
                    ]),
                    Gap(majorGapVertical),
                    const SocialLoginOptions(),
                    Gap(20.h),
                  ],
                ),
                if (authState.event is SocialLoginEvent &&
                    authState.state == BlocState.loading)
                  const Positioned.fill(child: CommonLoader())
              ],
            ));
  }

  Widget _continueButton(AuthState authState) {
    return Column(
      key: globalKey,
      children: [
        Gap(majorGapVertical),
        AppCommonButton(
            buttonName: S.current.continueText,
            validations: [
              authController.loginEmailController,
              authController.loginPasswordController
            ],
            isExpanded: true,
            isLoading: (authState.state == BlocState.loading &&
                authState.event is LoginEvent),
            onPressed: () {
              authController.add(LoginEvent(
                  email: authController.loginEmailController.text.trim(),
                  password:
                      authController.loginPasswordController.text.trim()));
            }),
        Gap(majorGapVertical)
      ],
    );
  }
}
