import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class AppState extends BlocEventState {
  AppState({
    super.response,
    super.event,
    super.state = BlocState.none,
  });

  @override
  AppState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      AppState(
          state: state ?? BlocState.none, event: event, response: response);
}
