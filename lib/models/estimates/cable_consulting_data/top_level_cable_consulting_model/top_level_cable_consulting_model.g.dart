// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_level_cable_consulting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopLevelCableConsultingIssueModel _$TopLevelCableConsultingIssueModelFromJson(
        Map<String, dynamic> json) =>
    TopLevelCableConsultingIssueModel(
      categoryName: json['categoryName'] as String,
      issueTypeNames: (json['issueTypeNames'] as List<dynamic>?)
          ?.map((e) => CableConsultingSubCategoryModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopLevelCableConsultingIssueModelToJson(
        TopLevelCableConsultingIssueModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'issueTypeNames': instance.issueTypeNames,
    };
