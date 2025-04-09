import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/estimates/estimate_requests_pagination_model.dart';

class CableConsultingDataStateStore {
  EstimateRequestListPaginationModel list =
      EstimateRequestListPaginationModel(models: [], nextHit: 0);
  void dispose() {
    list.models.clear();
  }
}

class CableConsultingDataState extends BlocEventState {
  CableConsultingDataStateStore store;
  CableConsultingDataState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  CableConsultingDataState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      CableConsultingDataState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response,
          store: store);
}
