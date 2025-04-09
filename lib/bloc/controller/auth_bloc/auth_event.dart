import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/edit_profile/edit_profile_model.dart';
import 'package:cobuild/models/onboarding/reset_password_model/reset_password_model.dart';
import 'package:cobuild/models/onboarding/signup_model/signup_model.dart';
import 'package:cobuild/models/onboarding/social_signup/social_signup_model.dart';
import 'package:cobuild/models/onboarding/verify_otp_api_model/verify_otp_api_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';

/// Authentication
abstract class AuthEvent extends BlocEvent {
  const AuthEvent();
}

class AuthInitialEvent extends AuthEvent {
  AuthInitialEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
}

class ForgotPasswordSendOTPEvent extends AuthEvent {
  final VerifyOtpApiModel model;
  const ForgotPasswordSendOTPEvent({required this.model});
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordModel model;
  const ResetPasswordEvent({required this.model});
}

class CompleteProfileDataEvent extends AuthEvent {
  final EditProfileModel model;
  const CompleteProfileDataEvent({required this.model});
}

class SocialSignupCompleteProfileInitDataEvent extends AuthEvent {
  final UserModel model;
  const SocialSignupCompleteProfileInitDataEvent({required this.model});
}

class SocialLoginEvent extends AuthEvent {
  SocialSignUpModel model;
  SocialLoginEvent({required this.model});
}

class SendSignupOtpEvent extends AuthEvent {
  final SignupModel model;

  const SendSignupOtpEvent({required this.model});
}
