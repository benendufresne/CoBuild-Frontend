import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class DamageReportDetailsEvent extends BlocEvent {
  const DamageReportDetailsEvent();
}

class DamageReportDetailsInitialEvent extends DamageReportDetailsEvent {
  const DamageReportDetailsInitialEvent();
}

/// Get Damage Reports Details
class GetDamageReportDetailsEvent extends DamageReportDetailsEvent {
  String damageReportId;
  GetDamageReportDetailsEvent({required this.damageReportId});
}
