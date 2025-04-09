import 'dart:io';

import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_sub_model/cable_consulting_sub_model.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/top_level_cable_consulting_model/top_level_cable_consulting_model.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/models/service_category/service_category.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';

abstract class EstimateRequestEvent extends BlocEvent {
  const EstimateRequestEvent();
}

class EstimateRequestInitialEvent extends EstimateRequestEvent {
  const EstimateRequestInitialEvent();
}

/// Create Estimates Request
class CreateEstimateRequestEvent extends EstimateRequestEvent {
  final EstimateRequestModel model;
  const CreateEstimateRequestEvent({required this.model});
}

class UpdateEstimateRequestEvent extends EstimateRequestEvent {
  final EstimateRequestModel model;
  const UpdateEstimateRequestEvent({required this.model});
}

class SelectServiceTypeInCreateRequestEvent extends EstimateRequestEvent {
  final ServiceTypeEnum type;
  const SelectServiceTypeInCreateRequestEvent({required this.type});
}

// Select Service Cateogory
class SelectServiceCategoryCreateRequestEvent extends EstimateRequestEvent {
  final ServiceCategoryModel type;
  const SelectServiceCategoryCreateRequestEvent({required this.type});
}

/// Cable Consulting Issue
class SelectCableConsultingIssueInCreateRequestEvent
    extends EstimateRequestEvent {
  final TopLevelCableConsultingIssueModel type;
  const SelectCableConsultingIssueInCreateRequestEvent({required this.type});
}

class SelectCableConsultingsubIssueInCreateRequestEvent
    extends EstimateRequestEvent {
  final CableConsultingSubCategoryModel type;
  final String? name;
  const SelectCableConsultingsubIssueInCreateRequestEvent(
      {required this.type, this.name});
}

////

class InitDataInCreateRequestEvent extends EstimateRequestEvent {
  final EstimateRequestModel? model;
  const InitDataInCreateRequestEvent({this.model});
}

class SelectMediaInCreateRequestEvent extends EstimateRequestEvent {
  final File? file;
  const SelectMediaInCreateRequestEvent({required this.file});
}
