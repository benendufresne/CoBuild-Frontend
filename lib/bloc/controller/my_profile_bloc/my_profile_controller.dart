import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_event.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_state.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileController extends Bloc<MyProfileEvent, MyProfileState> {
  final MyProfileRepository _repository = MyProfileRepository();

  /// Delete Account
  final FocusNode deleteAccountPasswordFocus = FocusNode();
  ValidatedController deleteAccountPasswordController =
      ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  MyProfileController()
      : super(MyProfileState(
            state: BlocState.none,
            event: const MyProfileInitialEvent(),
            response: null,
            store: MyProfileStateStore())) {
    on<UpdateNotificationPreferenceEvent>(_updateNotificationPreference);
  }

  void setInitialNotificationOreference() {
    state.store.notificationPermission.value =
        GlobalRepository().hasNotificationPermission;
  }

  Future<void> _updateNotificationPreference(
      UpdateNotificationPreferenceEvent event,
      Emitter<MyProfileState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response =
        await _repository.updateNotificationPreference(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
