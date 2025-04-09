import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';

abstract class DamageReportEvent extends BlocEvent {
  const DamageReportEvent();
}

class DamageReportInitialEvent extends DamageReportEvent {
  const DamageReportInitialEvent();
}

class AddReportDamageEvent extends DamageReportEvent {
  final DamageModel model;
  const AddReportDamageEvent({required this.model});
}

/// Get damage Report List
class GetDamageReportListEvent extends DamageReportEvent {
  int pageNo;
  final bool isNextPage;
  GetDamageReportListEvent({this.pageNo = 1, this.isNextPage = false});
}
