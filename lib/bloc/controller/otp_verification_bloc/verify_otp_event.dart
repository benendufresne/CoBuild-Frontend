import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/onboarding/verify_otp_api_model/verify_otp_api_model.dart';

class OtpEvent extends BlocEvent {
  const OtpEvent();
}

class OtpInitialEvent extends OtpEvent {
  String? otp;
  OtpInitialEvent({this.otp});
}

/// Signup Email OTP Verification
class VerifyOtpEvent extends OtpEvent {
  final VerifyOtpApiModel model;
  const VerifyOtpEvent({required this.model});
}

class ResendOtpEvent extends OtpEvent {
  final VerifyOtpApiModel model;
  const ResendOtpEvent({required this.model});
}
