import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:flutter/material.dart';

import '../../base/bloc_event.dart';

/// Bottom navigation bar State
class BottomNavigationStateStore {
  ValueNotifier<int> currentBottomNavPage = ValueNotifier(0);

  void dispose() {
    currentBottomNavPage.value = 0;
  }
}

class BottomNavigationState extends BlocEventState {
  BottomNavigationState({
    super.response,
    super.event,
    required this.store,
    super.state = BlocState.none,
  });
  BottomNavigationStateStore store;
  @override
  BottomNavigationState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      BottomNavigationState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
