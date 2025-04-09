import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_controller.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_event.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_state.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_evevt.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_state.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstimateController extends Bloc<EstimateEvent, EstimateState> {
  final EstimateRepository _repository = EstimateRepository();

  EstimateController()
      : super(EstimateState(
            state: BlocState.none,
            event: const EstimateInitialEvent(),
            response: null,
            store: EstimateStateStore())) {
    on<DeleteEstimateRequestEvent>(_delete);
  }

  FutureOr _delete(
      DeleteEstimateRequestEvent event, Emitter<EstimateState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.deleteEstimateRequest(event);
    if (response.state == BlocState.success) {
      if (event.isCompleted && ctx.mounted) {
        ctx
            .read<CompletedEstimateController>()
            .add(DeleteCompletedEstimatesEvent(id: event.estimateId));
      } else {
        if (ctx.mounted) {
          ctx
              .read<ActiveEstimateController>()
              .add(DeleteActiveEstimatesEvent(id: event.estimateId));
        }
      }
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
