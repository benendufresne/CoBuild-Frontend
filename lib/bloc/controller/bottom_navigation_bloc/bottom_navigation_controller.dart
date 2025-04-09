import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_state.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// To handle Bottom navigation bar of Application
///
/// Index
// 1 :- for Home page ,
// 2 :- Report damage
// 3 :- Notification
// 4 :- Profile

class BottomNavigationController
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  late TabController tabController;
  BottomNavigationController()
      : super(BottomNavigationState(
            state: BlocState.none,
            event: const BottomNavigationInitialEvent(),
            response: null,
            store: BottomNavigationStateStore())) {
    on<ChangeSelectedTabEvent>(_changeSelectedTab);
  }

  /// Change Selected Tab
  Future<void> _changeSelectedTab(
      ChangeSelectedTabEvent event, Emitter<BottomNavigationState> emit) async {
    /// While tapping on current page
    if (state.store.currentBottomNavPage.value ==
        (event.index ?? BottomNavEnum.getIndex(event.type))) {
      return;
    }
    state.store.currentBottomNavPage.value =
        event.index ?? BottomNavEnum.getIndex(event.type);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  void resetAllValues() {
    state.store.dispose();
  }
}
