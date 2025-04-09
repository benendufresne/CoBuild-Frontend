import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class UserProfileState extends BlocEventState {
  UserProfileState({
    super.response,
    super.event,
    super.state = BlocState.none,
  });

  @override
  UserProfileState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      UserProfileState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response);
}
