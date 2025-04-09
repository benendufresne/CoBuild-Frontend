import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_state.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstimateDetailsController
    extends Bloc<EstimateDetailsEvent, EstimateDetailsState> {
  final EstimateRepository _repository = EstimateRepository();
  EstimateDetailsController()
      : super(EstimateDetailsState(
            state: BlocState.none,
            event: const EstimateDetailsInitialEvent(),
            response: null,
            store: EstimateDetailsStateStore())) {
    on<GetEstimateDetailsEvent>(_getEstimateDetails);
  }

  Future<void> _getEstimateDetails(
      GetEstimateDetailsEvent event, Emitter<EstimateDetailsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getEstimateDetails(event);
    if (response.state == BlocState.success) {
      state.store.model =
          EstimateRequestModel.fromJson(response.data[ApiKeys.data]);
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
