import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/bloc/repositories/onboarding_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/edit_profile/edit_profile_model.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/models/onboarding/reset_password_model/reset_password_model.dart';
import 'package:cobuild/models/onboarding/signup_model/signup_model.dart';
import 'package:cobuild/models/onboarding/social_signup/social_signup_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/models/verify_otp_model/verify_otp_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/enums/onboarding_enum.dart';
import 'package:cobuild/utils/services/social_logins.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthController extends Bloc<AuthEvent, AuthState> {
  final OnboardingRepository _repository = OnboardingRepository();

  /// For login page
  final FocusNode loginEmailFocus = FocusNode();
  final FocusNode loginPasswordFocus = FocusNode();
  ValidatedController loginEmailController = ValidatedController.notEmpty(
    validation: Validation.string.email(),
  );
  ValidatedController loginPasswordController = ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );

  /// For Complete Profile
  final FocusNode nameFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  ValidatedController completeProfileNameController =
      ValidatedController.notEmpty(
    validation: Validation.string.name(),
  );
  ValidatedController completeProfileAddressController =
      ValidatedController.notEmpty(
    validation: Validation.string.addrress(),
  );
  LocationModel? completeProfileLocationModel = LocationModel();

  /// For signup screen
  final FocusNode signupPhoneFocus = FocusNode();
  final FocusNode signupEmailFocus = FocusNode();
  final FocusNode signupPasswordFocus = FocusNode();
  ValidatedController signupPhoneController = ValidatedController.notEmpty(
    validation: Validation.string.phone(),
  );
  ValidatedController signupEmailController = ValidatedController.notEmpty(
    validation: Validation.string.email(),
  );
  ValidatedController signupPasswordController = ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  CountryCode signupCountrycode = defaultCountryCode;

  /// For Forgot Password
  final FocusNode forgotPasswordEmailFocus = FocusNode();
  ValidatedController forgotPasswordEmailController =
      ValidatedController.notEmpty(
    validation: Validation.string.email(),
  );

  /// Reset Password
  final FocusNode resetPasswordFocus = FocusNode();
  final FocusNode resetConfirmPasswordFocus = FocusNode();
  final ValidatedController<PasswordValidation> resetPasswordController =
      ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  late final ValidatedController resetConfirmPasswordController =
      RepeatPasswordValidatedController.notEmpty(
    mainPasswordController: resetPasswordController,
  );

  AuthController()
      : super(AuthState(
            state: BlocState.none,
            event: AuthInitialEvent(),
            response: null,
            stateStore: AuthStateStore())) {
    /// Login
    on<LoginEvent>(_login);
    on<ForgotPasswordSendOTPEvent>(_forgotPasswordSendOtp);
    on<ResetPasswordEvent>(_resetPassword);
    on<CompleteProfileDataEvent>(_completeProfile);
    on<SocialLoginEvent>(_socialLogin);
    on<SocialSignupCompleteProfileInitDataEvent>(
        _completeProfileSocialSignupInitData);
    on<SendSignupOtpEvent>(_sendSignupOtp);
  }

  /// Login
  FutureOr<void> _login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.login(event);
    if (response.state == BlocState.success && response.data != null) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      if ((model.isProfileCompleted ?? false) && (ctx.mounted)) {
        ctx.goNamed(AppRoutes.bottomNavigation);
      } else if (ctx.mounted) {
        ctx.goNamed(AppRoutes.completeProfile);
      }
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Forgot Password => Send OTP
  FutureOr<void> _forgotPasswordSendOtp(
    ForgotPasswordSendOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.forgotPasswordSendOtp(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Reset Password
  FutureOr<void> _resetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.resetPassword(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Complete initial profile data
  FutureOr<void> _completeProfile(
    CompleteProfileDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.completeProfileData(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Social Login
  FutureOr<void> _socialLogin(
    SocialLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    SocialSignUpModel? model;
    if (event.model.socialLoginId?.isEmpty ?? true) {
      if (event.model.socialLoginType == SocialLoginType.google.backendEnum) {
        model = await SocialLogins.googleLogin();
      } else if (event.model.socialLoginType ==
          SocialLoginType.facebook.backendEnum) {
        // model = await SocialLogins.facebookLogin();
      }
      if (event.model.socialLoginType == SocialLoginType.apple.backendEnum) {
        model = await SocialLogins.appleLogin();
      }
    } else {
      model = event.model;
    }
    if (model != null) {
      event.model = model;
      BlocResponse response = await _repository.socialSignUp(event);
      if (response.state == BlocState.success && response.data != null) {
        UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
        if ((model.isProfileCompleted ?? false) && (ctx.mounted)) {
          ctx.goNamed(AppRoutes.bottomNavigation);
        } else if (ctx.mounted) {
          ctx.goNamed(AppRoutes.completeProfileForSocialLogin,
              extra: {AppKeys.model: model});
        }
      } else if (response.state == BlocState.failed &&
          response.data != null &&
          ctx.mounted) {
        if (event.model.socialLoginId?.isNotEmpty ?? false) {
          if (response.data[ApiKeys.type] ==
              ErrorCases.emailNotFoundInAppleLogin) {
            ctx.goNamed(AppRoutes.signup,
                extra: {AppKeys.id: event.model.socialLoginId});
          }
        }
      }
      emit(state.copyWith(
          state: response.state ?? BlocState.failed, response: response));
    } else {
      emit(state.copyWith(state: BlocState.failed));
    }
  }

  FutureOr<void> _completeProfileSocialSignupInitData(
    SocialSignupCompleteProfileInitDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    clearCompleteProfileFields();
    clearSignupFields();
    completeProfileNameController.text = event.model.name ?? '';
    signupEmailController.text = event.model.email ?? '';
    signupPhoneController.text = event.model.mobileNo ?? '';
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  /// Verify Email in Signup
  FutureOr<void> _sendSignupOtp(
    SendSignupOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.sendSignupOtp(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  SignupModel getSignupModel({String? socialId}) {
    SignupModel model = SignupModel(
        email: signupEmailController.value.trim(),
        countryCode: signupCountrycode.dialCode ?? "",
        flagCode: signupCountrycode.code ?? "",
        mobileNo: signupPhoneController.value.trim());
    if (socialId?.isNotEmpty ?? false) {
      model.socialLoginId = socialId;
    } else {
      model.password = signupPasswordController.value.trim();
    }
    return model;
  }

  /// For Signup
  VerifyOtpModel getVerifyOtpSignupModel() {
    return VerifyOtpModel(
      type: VerifyOtpEnum.signupEmail,
      email: signupEmailController.value.trim(),
    );
  }

  /// For Forgot Password
  VerifyOtpModel getVerifyForgotPasswordModel() {
    return VerifyOtpModel(
      type: VerifyOtpEnum.forgotPassword,
      email: forgotPasswordEmailController.value.trim(),
    );
  }

  /// Get Reset Password Model
  ResetPasswordModel getResetPasswordModel() {
    return ResetPasswordModel(
      email: forgotPasswordEmailController.value.trim(),
      password: resetPasswordController.value.trim(),
      confirmPassword: resetConfirmPasswordController.value.trim(),
    );
  }

  /// Get complete Profile Model
  EditProfileModel getCompleteProfileModel() {
    return EditProfileModel(
      name: completeProfileNameController.value.trim(),
      location: completeProfileLocationModel,
    );
  }

  /// Get complete Profile Model social signup
  EditProfileModel getCompleteProfileModelForSocialSignup() {
    return EditProfileModel(
      name: completeProfileNameController.value.trim(),
      email: signupEmailController.value.trim(),
      // Mobile
      countryCode: signupCountrycode.dialCode ?? "",
      flagCode: signupCountrycode.code ?? "",
      mobileNo: signupPhoneController.value.trim(),
      // location
      location: completeProfileLocationModel,
    );
  }

  /// Clear Login inputFields
  void clearLoginFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  /// Clear Signup fields
  void clearSignupFields() {
    signupEmailController.clear();
    signupPhoneController.clear();
    signupPasswordController.clear();
    signupCountrycode = defaultCountryCode;
    state.stateStore.acceptTermAndConditions.value = false;
  }

  /// Clear Forgot Password fields
  void clearForgotPasswordFields() {
    forgotPasswordEmailController.clear();
  }

  /// Clear Reset Password fields
  void clearResetPasswordFields() {
    resetPasswordController.clear();
    resetConfirmPasswordController.clear();
  }

  /// Clear Complete Profile fields
  void clearCompleteProfileFields() {
    completeProfileNameController.clear();
    completeProfileAddressController.clear();
    completeProfileLocationModel = LocationModel();
  }

  @override
  Future<void> close() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    return super.close();
  }
}
