import 'dart:async';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_event.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileController extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileController()
      : super(UserProfileState(
          state: BlocState.none,
          event: UserProfileInitialEvent(),
          response: null,
        )) {
    /// Update UI on user data updation
    on<UpdateUserProfileUIEvent>(_updateUI);
  }

  Future<void> _updateUI(
      UpdateUserProfileUIEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(state: BlocState.success, event: event));
  }
}
