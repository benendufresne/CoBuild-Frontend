import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/estimates/estimate_requests_pagination_model.dart';

class CompletedEstimateStateStore {
  EstimateRequestListPaginationModel list =
      EstimateRequestListPaginationModel(models: [], nextHit: 0);
  void dispose() {
    list.models.clear();
    list.nextHit = 0;
  }
}

class CompletedEstimateState extends BlocEventState {
  CompletedEstimateStateStore store;
  CompletedEstimateState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  CompletedEstimateState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      CompletedEstimateState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
