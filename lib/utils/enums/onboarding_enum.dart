enum VerifyOtpEnum { signupEmail, forgotPassword }

extension VerifyOtpEnumValues on VerifyOtpEnum {
  String get getBackendEnum {
    switch (this) {
      case VerifyOtpEnum.signupEmail:
        return 'SIGNUP';
      case VerifyOtpEnum.forgotPassword:
        return 'FORGOT_PASSWORD';
    }
  }
}
