import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';

class DamageReportListPaginationModel {
  List<DamageModel> models;
  int nextHit;

  DamageReportListPaginationModel(
      {required this.models, required this.nextHit});
}
