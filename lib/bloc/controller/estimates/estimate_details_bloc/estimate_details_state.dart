import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';

class EstimateDetailsStateStore {
  EstimateRequestModel? model;

  void dispose() {
    model = null;
  }
}

class EstimateDetailsState extends BlocEventState {
  EstimateDetailsStateStore store;
  EstimateDetailsState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  EstimateDetailsState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      EstimateDetailsState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
