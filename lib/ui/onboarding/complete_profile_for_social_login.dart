import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text_fields/address_text_field.dart';
import 'package:cobuild/ui/components/text_fields/email_text_field.dart';
import 'package:cobuild/ui/components/text_fields/name_text_field.dart';
import 'package:cobuild/ui/components/text_fields/phone_text_field.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Complete profile screen :-if user sign up through social login
class CompleteProfileForSocialLoginScreen extends StatefulWidget {
  final UserModel? model;
  const CompleteProfileForSocialLoginScreen({super.key, this.model});

  @override
  State<StatefulWidget> createState() =>
      _CompleteProfileForSocialLoginScreenState();
}

class _CompleteProfileForSocialLoginScreenState
    extends State<CompleteProfileForSocialLoginScreen> {
  late AuthController controller;
  GlobalKey globalKey = GlobalKey();
  bool showNameField = true;
  bool showEmailField = true;
  bool showPhoneField = true;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    _prefilledData();
  }

  void _prefilledData() {
    if (widget.model != null) {
      showNameField = widget.model?.name?.isEmpty ?? true;
      showEmailField = widget.model?.email?.isEmpty ?? true;
      showPhoneField = widget.model?.mobileNo?.isEmpty ?? true;
      controller
          .add(SocialSignupCompleteProfileInitDataEvent(model: widget.model!));
    }
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
                image: AppImages.completeProfile, height: 60.sp, width: 60.sp),
            Gap(20.h),
            Header2(heading: S.current.completeYourProfile),
            Gap(8.h),
            Title1(title: S.current.completeProfileDescription),
            Gap(fieldGap),
            if (showNameField) ...[_nameTextField(), Gap(fieldGap)],
            if (showEmailField) ...[_emailTextField(), Gap(fieldGap)],
            if (showPhoneField) ...[_phoneTextField(), Gap(fieldGap)],
            _addressTextField(),
            Gap(30.h),
            _continue()
          ],
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return NameTextField(
      controller: controller.completeProfileNameController,
      focusNode: controller.nameFocus,
      onTap: () => onTapTextfield(globalKey),
      isOnboarding: true,
    );
  }

  Widget _emailTextField() {
    return EmailTextField(
      controller: controller.signupEmailController,
      focusNode: controller.signupEmailFocus,
      onTap: () => onTapTextfield(globalKey),
      isOnboarding: true,
    );
  }

  Widget _phoneTextField() {
    return PhoneTextField(
      controller: controller.signupPhoneController,
      focusNode: controller.signupPhoneFocus,
      countryCodeController: controller.signupCountrycode,
      onTap: () => onTapTextfield(globalKey),
      isOnboarding: true,
    );
  }

  Widget _addressTextField() {
    return AddressTextField(
      controller: controller.completeProfileAddressController,
      focusNode: controller.addressFocus,
      onTap: () => onTapTextfield(globalKey),
      isOnboarding: true,
      locationModel: controller.completeProfileLocationModel,
    );
  }

  Widget _continue() {
    return Column(
      key: globalKey,
      children: [
        BlocBuilderNew<AuthController, AuthState>(
            onSuccess: (authState) {
              if (authState.event is CompleteProfileDataEvent) {
                _showSuccessDialog();
              }
            },
            defaultView: (authState) => AppCommonButton(
                buttonName: S.current.continueText,
                isExpanded: true,
                isLoading: (authState.event is CompleteProfileDataEvent &&
                    authState.state == BlocState.loading),
                validations: validationsList,
                onPressed: () {
                  controller.add(CompleteProfileDataEvent(
                      model:
                          controller.getCompleteProfileModelForSocialSignup()));
                })),
        Gap(majorGap)
      ],
    );
  }

  List<BaseValidator<dynamic, Validation<dynamic>>>? get validationsList {
    List<BaseValidator<dynamic, Validation<dynamic>>>? validations = [
      controller.completeProfileAddressController
    ];
    if (showNameField) {
      validations.add(controller.completeProfileNameController);
    }
    if (showEmailField) {
      validations.add(controller.signupEmailController);
    }
    if (showPhoneField) {
      validations.add(controller.signupPhoneController);
    }
    return validations;
  }

  void _showSuccessDialog() {
    DialogBox().successDialog(
        subtitle: S.current.accountCreatedSuccessfully,
        onTap: () {
          context.goNamed(AppRoutes.bottomNavigation);
        });
  }
}
