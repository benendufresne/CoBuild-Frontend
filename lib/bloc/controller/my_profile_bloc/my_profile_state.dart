import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:flutter/material.dart';

class MyProfileStateStore {
  ValueNotifier<bool> notificationPermission = ValueNotifier(false);

  void dispose() {
    notificationPermission.dispose();
  }
}

class MyProfileState extends BlocEventState {
  MyProfileStateStore store;
  MyProfileState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  int selectedIndex = 0;
  @override
  MyProfileState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      MyProfileState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
