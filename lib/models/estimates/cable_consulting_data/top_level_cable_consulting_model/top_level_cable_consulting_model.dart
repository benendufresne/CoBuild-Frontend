import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_sub_model/cable_consulting_sub_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'top_level_cable_consulting_model.g.dart';

@JsonSerializable()
class TopLevelCableConsultingIssueModel {
  final String categoryName;
  final List<CableConsultingSubCategoryModel>? issueTypeNames;

  TopLevelCableConsultingIssueModel({
    required this.categoryName,
    this.issueTypeNames,
  });

  factory TopLevelCableConsultingIssueModel.fromJson(
          Map<String, dynamic> json) =>
      _$TopLevelCableConsultingIssueModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TopLevelCableConsultingIssueModelToJson(this);
}
