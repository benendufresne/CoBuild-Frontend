import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';

class DamageReportDetailsStateStore {
  DamageModel? model;

  void dispose() {
    model = null;
  }
}

class DamageReportDetailsState extends BlocEventState {
  DamageReportDetailsStateStore store;
  DamageReportDetailsState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  DamageReportDetailsState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      DamageReportDetailsState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
