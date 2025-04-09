import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/report_damage/damage_report_pagination_model.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';

class ReportedDamageListStateStore {
  DamageReportListPaginationModel list =
      DamageReportListPaginationModel(models: <DamageModel>[], nextHit: 1);
  void dispose() {}
}

class ReportedDamageListState extends BlocEventState {
  ReportedDamageListStateStore store;
  ReportedDamageListState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  ReportedDamageListState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      ReportedDamageListState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response,
          store: store);
}
