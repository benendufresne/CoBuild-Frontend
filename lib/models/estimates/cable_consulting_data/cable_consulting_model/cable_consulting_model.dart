import 'package:cobuild/models/estimates/cable_consulting_data/top_level_cable_consulting_model/top_level_cable_consulting_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cable_consulting_model.g.dart';

@JsonSerializable()
class CableConsultingModel {
  final List<TopLevelCableConsultingIssueModel> data;
  CableConsultingModel({required this.data});

  factory CableConsultingModel.fromJson(Map<String, dynamic> json) =>
      _$CableConsultingModelFromJson(json);
  Map<String, dynamic> toJson() => _$CableConsultingModelToJson(this);
}
