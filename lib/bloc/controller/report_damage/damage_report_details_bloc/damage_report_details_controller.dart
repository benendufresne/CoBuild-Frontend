import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_event.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_state.dart';
import 'package:cobuild/bloc/repositories/damage_report_repo.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DamageReportDetailsController
    extends Bloc<DamageReportDetailsEvent, DamageReportDetailsState> {
  final DamageReportRepository _repository = DamageReportRepository();
  DamageReportDetailsController()
      : super(DamageReportDetailsState(
            state: BlocState.none,
            event: const DamageReportDetailsInitialEvent(),
            response: null,
            store: DamageReportDetailsStateStore())) {
    on<GetDamageReportDetailsEvent>(_getDamageReportDetails);
  }

  Future<void> _getDamageReportDetails(GetDamageReportDetailsEvent event,
      Emitter<DamageReportDetailsState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.damageReportDetail(event);
    if (response.state == BlocState.success) {
      state.store.model = DamageModel.fromJson(response.data[ApiKeys.data]);
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
