import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class EditProfileStateStore {
  void dispose() {}
}

class EditProfileState extends BlocEventState {
  EditProfileState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.stateStore});
  EditProfileStateStore stateStore;

  @override
  EditProfileState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      EditProfileState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response,
          stateStore: stateStore);
}
