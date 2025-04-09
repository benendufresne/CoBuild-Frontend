import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class DeleteAccountState extends BlocEventState {
  DeleteAccountState({
    super.response,
    super.event,
    super.state = BlocState.none,
  });

  @override
  DeleteAccountState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      DeleteAccountState(
        state: state ?? BlocState.none,
        event: event ?? this.event,
        response: response,
      );
}
