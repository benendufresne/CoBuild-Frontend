import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_event.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_state.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveEstimateController
    extends Bloc<ActiveEstimateEvent, ActiveEstimateState> {
  final EstimateRepository _repository = EstimateRepository();

  ActiveEstimateController()
      : super(ActiveEstimateState(
            state: BlocState.none,
            event: const ActiveEstimateInitialEvent(),
            response: null,
            store: ActiveEstimateStateStore())) {
    on<GetActiveEstimatesEvent>(_getCompletedEstimateList);
    on<AddCreatedEstimatesEvent>(_addCreatedEstimate);
    on<ClearActiveEstimateDataOnLogout>(_clearDataOnLogout);
    on<DeleteActiveEstimatesEvent>(_delete);
  }

  FutureOr _getCompletedEstimateList(
      GetActiveEstimatesEvent event, Emitter<ActiveEstimateState> emit) async {
    printCustom("next hit is ${state.store.list.nextHit}");
    if (event.isNextPage && state.store.list.nextHit <= 1) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.isNextPage) {
      event.pageNo = state.store.list.nextHit;
    }
    BlocResponse response = await _repository.getActiveEstimatesList(event);
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

  FutureOr _addCreatedEstimate(
      AddCreatedEstimatesEvent event, Emitter<ActiveEstimateState> emit) async {
    if (state.store.list.models.isNotEmpty) {
      state.store.list.models.insert(0, event.model);
    } else {
      state.store.list.models = [event.model];
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr _delete(DeleteActiveEstimatesEvent event,
      Emitter<ActiveEstimateState> emit) async {
    state.store.list.models.removeWhere((element) => element.sId == event.id);
    emit(state.copyWith(state: BlocState.loading, event: event));
  }

  bool get isDataListEmpty => state.store.list.models.isEmpty;

  bool get isLoadingNextPageData {
    if ((state.event is GetActiveEstimatesEvent &&
        state.state == BlocState.loading)) {
      GetActiveEstimatesEvent currentEvent =
          state.event as GetActiveEstimatesEvent;
      if (currentEvent.isNextPage) {
        return true;
      }
    }
    return false;
  }

  FutureOr _clearDataOnLogout(ClearActiveEstimateDataOnLogout event,
      Emitter<ActiveEstimateState> emit) async {
    state.store.dispose();
    emit(state.copyWith(state: BlocState.success, event: event));
  }
}
