import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class ChangePasswordStateStore {
  void dispose() {}
}

class ChangePasswordState extends BlocEventState {
  ChangePasswordState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.stateStore});
  ChangePasswordStateStore stateStore;

  @override
  ChangePasswordState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      ChangePasswordState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response,
          stateStore: stateStore);
}
