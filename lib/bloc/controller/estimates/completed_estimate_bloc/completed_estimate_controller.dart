import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_state.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_extimate_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_event.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedEstimateController
    extends Bloc<CompletedEstimateEvent, CompletedEstimateState> {
  final EstimateRepository _repository = EstimateRepository();

  CompletedEstimateController()
      : super(CompletedEstimateState(
            state: BlocState.none,
            event: const EstimateRequestInitialEvent(),
            response: null,
            store: CompletedEstimateStateStore())) {
    on<GetCompletedEstimatesEvent>(_getCompletedEstimateList);
    on<ClearCompletedEstimateDataOnLogout>(_clearDataOnLogout);
    on<DeleteCompletedEstimatesEvent>(_delete);
  }

  FutureOr _getCompletedEstimateList(GetCompletedEstimatesEvent event,
      Emitter<CompletedEstimateState> emit) async {
    if (event.isNextPage && state.store.list.nextHit <= 1) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.isNextPage) {
      event.pageNo = state.store.list.nextHit;
    }
    BlocResponse response = await _repository.getCompletedEstimateList(event);
    if (response.state == BlocState.success) {
      List<dynamic> list = response.data[ApiKeys.data];
      List<EstimateRequestModel> requestList =
          list.map((e) => EstimateRequestModel.fromJson(e)).toList();
      if (event.pageNo == 1) {
        state.store.list.models = requestList;
      } else {
        state.store.list.models.addAll(requestList);
      }
      state.store.list.nextHit = response.data[ApiKeys.nextHit];
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  FutureOr _delete(DeleteCompletedEstimatesEvent event,
      Emitter<CompletedEstimateState> emit) async {
    state.store.list.models.removeWhere((element) => element.sId == event.id);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  bool get isDataListEmpty => state.store.list.models.isEmpty;

  bool get isLoadingNextPageData {
    if ((state.event is GetCompletedEstimatesEvent &&
        state.state == BlocState.loading)) {
      GetCompletedEstimatesEvent currentEvent =
          state.event as GetCompletedEstimatesEvent;
      if (currentEvent.isNextPage) {
        return true;
      }
    }
    return false;
  }

  FutureOr _clearDataOnLogout(ClearCompletedEstimateDataOnLogout event,
      Emitter<CompletedEstimateState> emit) async {
    state.store.dispose();
    emit(state.copyWith(state: BlocState.success, event: event));
  }
}
