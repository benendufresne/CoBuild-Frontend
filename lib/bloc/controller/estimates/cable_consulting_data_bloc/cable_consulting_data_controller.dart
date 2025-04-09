import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/cable_consulting_data_bloc/cable_consulting_data_event.dart';
import 'package:cobuild/bloc/controller/estimates/cable_consulting_data_bloc/cable_consulting_data_state.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CableConsultingDataController
    extends Bloc<CableConsultingDataEvent, CableConsultingDataState> {
  final EstimateRepository _repository = EstimateRepository();

  CableConsultingDataController()
      : super(CableConsultingDataState(
            state: BlocState.none,
            event: const CableConsultingDataInitialEvent(),
            response: null,
            store: CableConsultingDataStateStore())) {
    on<GetCableConsultingDataEvent>(_getCableConsultingDataList);
  }

  FutureOr _getCableConsultingDataList(GetCableConsultingDataEvent event,
      Emitter<CableConsultingDataState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getCableConsultingData(event);
    if (response.state == BlocState.success) {
      List<dynamic> list = response.data[ApiKeys.data];
      List<EstimateRequestModel> requestList =
          list.map((e) => EstimateRequestModel.fromJson(e)).toList();
      state.store.list.models = requestList;
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
