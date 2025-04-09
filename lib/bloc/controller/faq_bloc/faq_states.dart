import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:flutter/material.dart';

class FAQStateStore {
  ValueNotifier<int> faqCardCurrentIndex = ValueNotifier(0);

  void dispose() {
    faqCardCurrentIndex.dispose();
  }
}

class FAQState extends BlocEventState {
  FAQStateStore store;
  FAQState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  int selectedIndex = 0;
  @override
  FAQState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      FAQState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
