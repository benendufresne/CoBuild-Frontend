import 'dart:io';

import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';

abstract class AddDamageEvent extends BlocEvent {
  const AddDamageEvent();
}

class AddDamageInitialEvent extends AddDamageEvent {
  const AddDamageInitialEvent();
}

class AddDamageReportEvent extends AddDamageEvent {
  final DamageModel model;
  const AddDamageReportEvent({required this.model});
}

class AddMediaInDamageReportEvent extends AddDamageEvent {
  final List<File>? files;
  const AddMediaInDamageReportEvent({required this.files});
}
