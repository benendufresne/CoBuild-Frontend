import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/estimates/estimate_requests_pagination_model.dart';

class ActiveEstimateStateStore {
  EstimateRequestListPaginationModel list =
      EstimateRequestListPaginationModel(models: [], nextHit: 1);
  void dispose() {
    list.models.clear();
    list.nextHit = 0;
  }
}

class ActiveEstimateState extends BlocEventState {
  ActiveEstimateStateStore store;
  ActiveEstimateState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  ActiveEstimateState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      ActiveEstimateState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
