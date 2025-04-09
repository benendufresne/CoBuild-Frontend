import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/change_password_bloc/change_password_event.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_account_event.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_event.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_events.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_event.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/faq_model/faq_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MyProfileRepository extends AppRepository {
  static _MyProfileRepositoryImpl? _instance;

  factory MyProfileRepository() {
    return _instance ??= _MyProfileRepositoryImpl();
  }

  List<FAQModel> get faqs;

  /// Delete Account
  Future<BlocResponse> deleteAccount(DeleteAccountEvent event);
  Future<BlocResponse> getFAQs(GetFAQsEvent event);
  Future<BlocResponse> changePassword(ChangePasswordEvent event);
  Future<BlocResponse> editProfile(EditProfileEvent event);
  Future<BlocResponse> markAllNotificationsAsSeen(
      MarkAllNotificationsAsSeenEvent event);
  Future<BlocResponse> updateNotificationPreference(
      UpdateNotificationPreferenceEvent event);
}

class _MyProfileRepositoryImpl implements MyProfileRepository {
  final HttpServices _apiService = HttpServices();
  List<FAQModel> _faqs = [];

  @override
  Future<BlocResponse> deleteAccount(DeleteAccountEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.deleteAccount,
        body: {ApiKeys.password: event.password});
    if (response.state == BlocState.success) {
      if (ctx.mounted) {
        ctx.read<AppController>().add(ClearAllGlobalDataEvent());
      }
    }
    return response;
  }

  @override
  Future<BlocResponse> getFAQs(GetFAQsEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.faq,
        addDeviceId: true,
        queryParams: {ApiKeys.pageNo: 1, ApiKeys.limit: 50},
        body: {});
    if (response.state == BlocState.success) {
      var data = response.data[ApiKeys.data][ApiKeys.data];
      List<dynamic> list = data.map((e) => FAQModel.fromJson(e)).toList();
      if (list.isNotEmpty) {
        _faqs = list.cast<FAQModel>();
      }
    }
    return response;
  }

  @override
  Future<BlocResponse> changePassword(ChangePasswordEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.changePassword, body: event.model.toJson());
    if (response.state == BlocState.success) {}
    return response;
  }

  /// Save user data
  _updateUserData(UserModel model) async {
    await GlobalRepository().updateUserData(model);
  }

  @override
  Future<BlocResponse> editProfile(EditProfileEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.userProfile, body: event.model.toJson());
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      _updateUserData(model);
    }
    return response;
  }

  @override
  Future<BlocResponse> updateNotificationPreference(
      UpdateNotificationPreferenceEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.userProfile, body: event.model.toJson());
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      _updateUserData(model);
    }
    return response;
  }

  @override
  Future<BlocResponse> markAllNotificationsAsSeen(
      MarkAllNotificationsAsSeenEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.userProfile,
        body: UserModel(allnotificationsSeen: true).toJson());
    if (response.state == BlocState.success) {
      UserModel model = UserModel.fromJson(response.data[ApiKeys.data]);
      model.allnotificationsSeen = true;
      _updateUserData(model);
    }
    return response;
  }

  @override
  List<FAQModel> get faqs => _faqs;

  @override
  Future<void> clearDataOnLogout() async {}
}
