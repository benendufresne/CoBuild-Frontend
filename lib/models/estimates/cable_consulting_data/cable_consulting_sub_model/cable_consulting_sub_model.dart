import 'package:json_annotation/json_annotation.dart';
part 'cable_consulting_sub_model.g.dart';

@JsonSerializable()
class CableConsultingSubCategoryModel {
  final String issueTypeName;
  final List<String>? subIssueNames;

  CableConsultingSubCategoryModel({
    required this.issueTypeName,
    this.subIssueNames,
  });

  factory CableConsultingSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CableConsultingSubCategoryModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CableConsultingSubCategoryModelToJson(this);
}
