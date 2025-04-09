import 'dart:async';

import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_event.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_state.dart';
import 'package:cobuild/bloc/repositories/damage_report_repo.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DamageReportListingController
    extends Bloc<DamageReportEvent, ReportedDamageListState> {
  final DamageReportRepository _repository = DamageReportRepository();
  DamageReportListingController()
      : super(ReportedDamageListState(
            state: BlocState.none,
            event: const DamageReportInitialEvent(),
            response: null,
            store: ReportedDamageListStateStore())) {
    on<GetDamageReportListEvent>(_getReportList);
    on<AddReportDamageEvent>(_addReportedDamage);
  }

  /// Get Report List
  _getReportList(GetDamageReportListEvent event,
      Emitter<ReportedDamageListState> emit) async {
    if (event.isNextPage && state.store.list.nextHit <= 1) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.isNextPage) {
      event.pageNo = state.store.list.nextHit;
    }
    BlocResponse response = await _repository.damageReportList(event);
    if (response.state == BlocState.success) {
      List<dynamic> list = response.data[ApiKeys.data];
      List<DamageModel> requestList =
          list.map((e) => DamageModel.fromJson(e)).toList();
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

  FutureOr _addReportedDamage(
      AddReportDamageEvent event, Emitter<ReportedDamageListState> emit) async {
    if (state.store.list.models.isNotEmpty) {
      state.store.list.models.insert(0, event.model);
    } else {
      state.store.list.models = [event.model];
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  bool get isDataListEmpty => state.store.list.models.isEmpty;

  bool get isLoadingNextPageData {
    if ((state.event is GetDamageReportListEvent &&
        state.state == BlocState.loading)) {
      GetDamageReportListEvent currentEvent =
          state.event as GetDamageReportListEvent;
      if (currentEvent.isNextPage) {
        return true;
      }
    }
    return false;
  }
}
