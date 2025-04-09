import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class AddDamageStateStore {
  void dispose() {}
}

class AddDamageState extends BlocEventState {
  AddDamageStateStore store;
  AddDamageState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  AddDamageState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      AddDamageState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response ?? this.response,
          store: store);
}
