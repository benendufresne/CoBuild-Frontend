import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class TutorialState extends BlocEventState {
  TutorialState({
    super.response,
    super.event,
    super.state = BlocState.none,
  });
  int selectedIndex = 0;
  @override
  TutorialState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      TutorialState(
        state: state ?? BlocState.none,
        event: event,
        response: response,
      );
}
