import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class EstimateRequestState extends BlocEventState {
  EstimateRequestState(
      {super.response, super.event, super.state = BlocState.none});
  int selectedIndex = 0;
  @override
  EstimateRequestState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      EstimateRequestState(
        state: state ?? BlocState.none,
        event: event,
        response: response,
      );
}
