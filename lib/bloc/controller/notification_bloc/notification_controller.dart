import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_controller.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_event.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_state.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/bloc/repositories/notifications_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/notifications/notification_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsController
    extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _repository = NotificationsRepository();
  final MyProfileRepository _profileRepo = MyProfileRepository();

  NotificationsController()
      : super(NotificationsState(
            state: BlocState.none,
            event: const NotificationsInitialEvent(),
            response: null,
            store: NotificationsStateStore())) {
    on<GetNotificationsEvent>(_notificationsList);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<ClearAllNotificationsEvent>(_clearAllNotifications);
    on<ReadNotificationEvent>(_readNotification);
    on<MarkAllNotificationsAsSeenEvent>(_allNotificationsSeen);
    on<ReceivedNewNotificationEvent>(_receivedNewNotification);
    on<DeleteNotificationsDataOnLogoutEvent>(_deleteData);
  }

  /// Get Notification List
  FutureOr _notificationsList(
      GetNotificationsEvent event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getNotifications(event);
    if (response.state == BlocState.success) {
      List<dynamic> list = response.data[ApiKeys.data];
      List<NotificationModel> requestList =
          list.map((e) => NotificationModel.fromJson(e)).toList();
      if (event.pageNo == 1) {
        state.store.notifocationsListPaginationModel.models = requestList;
      } else {
        state.store.notifocationsListPaginationModel.models.addAll(requestList);
      }
      state.store.notifocationsListPaginationModel.nextHit =
          response.data[ApiKeys.nextHit];
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        response: response,
        event: event));
    if (response.state == BlocState.success && event.pageNo == 1) {
      add(const MarkAllNotificationsAsSeenEvent());
    }
  }

  FutureOr _deleteNotification(
      DeleteNotificationEvent event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.deleteNotification(event);
    if (response.state == BlocState.success) {
      state.store.notifocationsListPaginationModel.models.remove(event.model);
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        response: response,
        event: event));
  }

  FutureOr _clearAllNotifications(ClearAllNotificationsEvent event,
      Emitter<NotificationsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.clearAllNotifications(event);
    if (response.state == BlocState.success) {
      state.store.notifocationsListPaginationModel.models.clear();
      state.store.notifocationsListPaginationModel.nextHit = 1;
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        response: response,
        event: event));
  }

  FutureOr _readNotification(
      ReadNotificationEvent event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.readNotification(event);
    if (response.state == BlocState.success) {
      event.model.isRead = true;
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        response: response,
        event: event));
  }

  FutureOr _allNotificationsSeen(MarkAllNotificationsAsSeenEvent event,
      Emitter<NotificationsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response =
        await _profileRepo.markAllNotificationsAsSeen(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        response: response,
        event: event));
  }

  FutureOr _receivedNewNotification(ReceivedNewNotificationEvent event,
      Emitter<NotificationsState> emit) async {
    if (ctx
            .read<BottomNavigationController>()
            .state
            .store
            .currentBottomNavPage
            .value ==
        2) {
      add(GetNotificationsEvent());
      return;
    }
    await GlobalRepository().markNewNotificationReceived(
        UpdateAllLocationSeenStatusLocallyEvent(seen: false));
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr _deleteData(DeleteNotificationsDataOnLogoutEvent event,
      Emitter<NotificationsState> emit) async {
    state.store.dispose();
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  bool get isEmptyList =>
      state.store.notifocationsListPaginationModel.models.isEmpty;

  bool get isLoadingNextPageData {
    if ((state.event is GetNotificationsEvent &&
        state.state == BlocState.loading)) {
      GetNotificationsEvent currentEvent = state.event as GetNotificationsEvent;
      if (currentEvent.isNextPage) {
        return true;
      }
    }
    return false;
  }
}
