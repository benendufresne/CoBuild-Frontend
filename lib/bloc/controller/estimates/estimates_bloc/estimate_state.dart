import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class EstimateStateStore {
  void dispose() {}
}

class EstimateState extends BlocEventState {
  EstimateStateStore store;
  EstimateState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  EstimateState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      EstimateState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
