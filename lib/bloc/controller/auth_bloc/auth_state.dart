import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:flutter/material.dart';

class AuthStateStore {
  ValueNotifier<bool> acceptTermAndConditions = ValueNotifier(false);

  void dispose() {
    acceptTermAndConditions.dispose();
  }
}

class AuthState extends BlocEventState {
  AuthState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.stateStore});
  AuthStateStore stateStore;

  @override
  AuthState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      AuthState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response,
          stateStore: stateStore);
}
