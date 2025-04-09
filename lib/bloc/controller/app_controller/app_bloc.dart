import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/app_controller/app_state.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/version_management/verion_management.dart';
import 'package:cobuild/models/version_management/app_version/app_version_model.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/services/socket/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Controller to handle Global(App Level) data
class AppController extends Bloc<AppEvent, AppState> {
  final GlobalRepository _repository = GlobalRepository();
  AppController()
      : super(AppState(
          state: BlocState.none,
          event: AppInitialEvent(),
          response: null,
        )) {
    /// Get User Profile
    on<GetUserProfileEvent>(_getUserProfile);
    // Logout user
    on<LogoutEvent>(_logout);
    // Clear data on logout
    on<ClearAllGlobalDataEvent>(_clearAppGlobalData);
    // Check app version
    on<CheckAppVersionEvent>(_checkAppVersion);
    // Mark as new notification received
    on<UpdateAllLocationSeenStatusLocallyEvent>(_markAsNewNotification);
  }

  /// Get User Profile :-
  Future<void> _getUserProfile(
      GetUserProfileEvent event, Emitter<AppState> emit) async {
    if (AppPreferences().getUserToken().isEmpty ||
        (state.event is GetUserProfileEvent &&
            state.state == BlocState.loading)) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getUserProfile(event);
    if (response.state == BlocState.success) {
      AppSocketService().initSocket(forceConnect: true);
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        event: event,
        response: response));
  }

  /// Check app version
  Future<void> _checkAppVersion(
      CheckAppVersionEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.checkAppVersion(event);
    if (response.state == BlocState.success) {
      AppVersionModel model = AppVersionModel.fromJson(response.data['data']);
      VersionManagement().showUpdateDialog(model: model);
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Clear All Data
  Future<void> _clearAppGlobalData(
      ClearAllGlobalDataEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    await _repository.clearUserData();

    emit(state.copyWith(state: BlocState.success));
  }

  Future<void> _markAsNewNotification(
      UpdateAllLocationSeenStatusLocallyEvent event,
      Emitter<AppState> emit) async {
    await _repository.markNewNotificationReceived(event);
    emit(state.copyWith(state: BlocState.success));
  }

  /// Log out
  Future<void> _logout(LogoutEvent event, Emitter<AppState> emit) async {
    if (state.event is LogoutEvent && state.state == BlocState.loading) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse? response;
    if (event.callApi) {
      response = await _repository.logout(event);
    } else {
      GlobalRepository().clearDataOnLogout();
    }
    if (ctx.mounted) {
      ctx.goNamed(AppRoutes.login);
    }
    emit(state.copyWith(state: response?.state ?? BlocState.failed));
  }
}
