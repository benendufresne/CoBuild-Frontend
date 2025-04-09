import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_controller.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int maxNotificationsInAPage = 20;

abstract class NotificationsRepository extends AppRepository {
  static _NotificationsRepositoryImpl? _instance;

  factory NotificationsRepository() {
    return _instance ??= _NotificationsRepositoryImpl();
  }

  /// Get Notifications List
  Future<BlocResponse> getNotifications(GetNotificationsEvent event);
  Future<BlocResponse> deleteNotification(DeleteNotificationEvent event);
  Future<BlocResponse> clearAllNotifications(ClearAllNotificationsEvent event);
  Future<BlocResponse> readNotification(ReadNotificationEvent event);
}

class _NotificationsRepositoryImpl implements NotificationsRepository {
  final HttpServices _apiService = HttpServices();

  @override
  Future<BlocResponse> getNotifications(GetNotificationsEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.notificationsList,
        queryParams: {
          ApiKeys.pageNo: event.pageNo,
          ApiKeys.limit: maxNotificationsInAPage
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> deleteNotification(DeleteNotificationEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.notificationsClear,
        body: {ApiKeys.notificationId: event.model.sId});
    return response;
  }

  @override
  Future<BlocResponse> clearAllNotifications(
      ClearAllNotificationsEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.notificationsClear, body: {});
    return response;
  }

  @override
  Future<BlocResponse> readNotification(ReadNotificationEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.readNotifications,
        body: {
          ApiKeys.notificationIds: [event.model.sId]
        });
    return response;
  }

  ///clear data on logout
  @override
  Future<void> clearDataOnLogout() async {
    ctx
        .read<NotificationsController>()
        .add(const DeleteNotificationsDataOnLogoutEvent());
  }
}
