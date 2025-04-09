import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_controller.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_controller.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/static_content_model/static_content_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GlobalRepository {
  static GlobalRepository? _instance;
  static String adminBaseUrl = baseUrlModel.adminBaseUrl;
  static StaticContentModel get staticContentModel => StaticContentModel(
        aboutUs: adminBaseUrl + ApiEndpoints.aboutUs,
        privacyPolicy: adminBaseUrl + ApiEndpoints.privacyPolicy,
        termsAndConditions: adminBaseUrl + ApiEndpoints.termsAndConditions,
        url: adminBaseUrl,
      );

  factory GlobalRepository() {
    return _instance ??= _GlobalRepositoryImpl();
  }

  UserModel? get userModel;

  String get name;
  bool get isSignupProcessCompleted;
  bool get allNotificationsSeen;
  String get email;

  bool get hasNotificationPermission;

  // Update user data model
  Future<void> updateUserData(UserModel model);
  // Update user data model
  Future<void> clearUserData();

  /// Get User Profile
  Future<BlocResponse> getUserProfile(GetUserProfileEvent event);

  /// Get Static content
  Future<BlocResponse> getStaticContent(GetStaticContentEvent event);

  /// Check App Version
  Future<BlocResponse> checkAppVersion(CheckAppVersionEvent event);

  Future<void> markNewNotificationReceived(
      UpdateAllLocationSeenStatusLocallyEvent event);

  /// Logout
  Future<BlocResponse> logout(LogoutEvent event);
  void clearDataOnLogout();
}

class _GlobalRepositoryImpl implements GlobalRepository {
  final HttpServices _apiService = HttpServices();
  @override
  Future<BlocResponse> getUserProfile(GetUserProfileEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.userProfile, body: {});
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      _saveDataOnLogIn(model);
    }
    return response;
  }

  @override
  Future<BlocResponse> getStaticContent(GetStaticContentEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.getStaticContent,
        authType: ApiAuthType.basicAuth);
    return response;
  }

  @override
  Future<BlocResponse> checkAppVersion(CheckAppVersionEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
      ApiRequest.apiGet,
      event,
      apiEndPoint: ApiEndpoints.checkAppVersion,
    );
    return response;
  }

  @override
  Future<BlocResponse> logout(LogoutEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.logout, body: {});
    if (response.state == BlocState.success) {
      await clearUserData();
    }
    return response;
  }

  @override
  Future<void> markNewNotificationReceived(
      UpdateAllLocationSeenStatusLocallyEvent event) async {
    userModel?.allnotificationsSeen = event.seen;
    if (ctx.mounted) {
      ctx.read<UserProfileController>().add(UpdateUserProfileUIEvent());
    }
  }

  /// Save user data on login
  _saveDataOnLogIn(UserModel model) async {
    await updateUserData(model);
  }

  /// User profile data :-
  UserModel _userModel = UserModel(name: AppPreferences.name);

  @override
  UserModel? get userModel => _userModel;

  @override
  Future<void> updateUserData(UserModel model) async {
    printCustom("update user model and model is ${model.toJson()}");
    if (model.name?.isNotEmpty ?? false) {
      userModel?.name = model.name;
    }
    if (model.email?.isNotEmpty ?? false) {
      userModel?.email = model.email;
    }
    if (model.mobileNo != null) {
      userModel?.mobileNo = model.mobileNo;
    }
    if (model.countryCode != null) {
      userModel?.countryCode = model.countryCode;
    }
    if (model.location != null) {
      userModel?.location = model.location;
    }
    if (model.notification != null) {
      userModel?.notification = model.notification;
    }
    if (model.allnotificationsSeen != null) {
      userModel?.allnotificationsSeen = model.allnotificationsSeen;
    }
    await AppPreferences.setUserLoginData(model: model);
    if (ctx.mounted) {
      ctx.read<UserProfileController>().add(UpdateUserProfileUIEvent());
    }
  }

  @override
  String get name => userModel?.name ?? S.current.user;
  @override
  String get email => userModel?.email ?? '';
  @override
  bool get allNotificationsSeen => userModel?.allnotificationsSeen ?? true;

  @override
  bool get hasNotificationPermission => userModel?.notification ?? true;

  @override
  bool get isSignupProcessCompleted => AppPreferences.isSignupProcessCompleted;

  ///clear user data
  @override
  Future<void> clearUserData() async {
    _userModel = UserModel();
    await AppPreferences.logout();
    await AppRepository().clearDataOnLogout();
  }

  @override
  Future<void> clearDataOnLogout() async {
    ctx.read<BottomNavigationController>().resetAllValues();
  }
}
