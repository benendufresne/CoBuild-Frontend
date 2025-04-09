import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/enums/onboarding_enum.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';

abstract class OnboardingRepository extends AppRepository {
  static _OnboardingRepositoryImpl? _instance;

  factory OnboardingRepository() {
    return _instance ??= _OnboardingRepositoryImpl();
  }

  /// Login
  Future<BlocResponse> login(LoginEvent event);

  /// Verify OTP
  Future<BlocResponse> verifySignupEmailOtp(VerifyOtpEvent event);

  /// Resend OTP
  Future<BlocResponse> resendSignupEmailOtp(ResendOtpEvent event);

  /// Forgot Password
  Future<BlocResponse> forgotPasswordSendOtp(ForgotPasswordSendOTPEvent event);

  /// Reset Password
  Future<BlocResponse> resetPassword(ResetPasswordEvent event);

  /// SocialSignUp
  Future<BlocResponse> socialSignUp(SocialLoginEvent event);

  /// Complete Profile
  Future<BlocResponse> completeProfileData(CompleteProfileDataEvent event);

  /// Send signup otp
  Future<BlocResponse> sendSignupOtp(SendSignupOtpEvent event);
}

class _OnboardingRepositoryImpl implements OnboardingRepository {
  final HttpServices _apiService = HttpServices();

  @override
  Future<BlocResponse> login(LoginEvent event) async {
    await _clearPreferencesOnLogout();
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.login,
        addDeviceId: true,
        body: {ApiKeys.email: event.email, ApiKeys.password: event.password});
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      await _saveDataOnLogIn(model);
      await _saveAccessToken(model.accessToken ?? "");
    }
    return response;
  }

  /// Send Signup OTP
  @override
  Future<BlocResponse> sendSignupOtp(SendSignupOtpEvent event) async {
    await _clearPreferencesOnLogout();
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.sendSignupOtp, body: event.model.toJson());
    return response;
  }

  /// Resend OTP
  @override
  Future<BlocResponse> resendSignupEmailOtp(ResendOtpEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.sendOtp, body: event.model.toJson());
    return response;
  }

  /// Verify OTP
  @override
  Future<BlocResponse> forgotPasswordSendOtp(
      ForgotPasswordSendOTPEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.sendOtp, body: event.model.toJson());
    return response;
  }

  /// Verify OTP
  @override
  Future<BlocResponse> verifySignupEmailOtp(VerifyOtpEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        addDeviceId: true,
        apiEndPoint: ApiEndpoints.verifySignupEmailOtp,
        body: event.model.toJson());
    if (response.state == BlocState.success) {
      if (event.model.type == VerifyOtpEnum.signupEmail.getBackendEnum) {
        UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
        _saveAccessToken(model.accessToken ?? '');
      }
    }
    return response;
  }

  @override
  Future<BlocResponse> resetPassword(ResetPasswordEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.resetPassword, body: event.model.toJson());
    return response;
  }

  /// ---------------- Social Signup --------------------
  @override
  Future<BlocResponse> socialSignUp(SocialLoginEvent event) async {
    await _clearPreferencesOnLogout();
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        addDeviceId: true,
        apiEndPoint: ApiEndpoints.socialLogin,
        body: event.model.toJson());
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      await _saveDataOnLogIn(model);
      await _saveAccessToken(model.accessToken ?? "");
    }
    return response;
  }

  /// Complete Profile Data
  @override
  Future<BlocResponse> completeProfileData(
      CompleteProfileDataEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.userProfile, body: event.model.toJson());
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      await _saveDataOnLogIn(model);
    }
    return response;
  }

  _saveAccessToken(String token) async {
    await AppPreferences.setAccessToken(token);
  }

  /// Save user data on login
  _saveDataOnLogIn(UserModel model) async {
    await GlobalRepository().updateUserData(model);
  }

  _clearPreferencesOnLogout() async {
    await AppPreferences.logout();
  }

  ///clear data on logout
  @override
  Future<void> clearDataOnLogout() async {}
}
