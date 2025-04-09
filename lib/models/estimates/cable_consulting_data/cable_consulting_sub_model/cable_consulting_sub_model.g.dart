// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cable_consulting_sub_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CableConsultingSubCategoryModel _$CableConsultingSubCategoryModelFromJson(
        Map<String, dynamic> json) =>
    CableConsultingSubCategoryModel(
      issueTypeName: json['issueTypeName'] as String,
      subIssueNames: (json['subIssueNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CableConsultingSubCategoryModelToJson(
        CableConsultingSubCategoryModel instance) =>
    <String, dynamic>{
      'issueTypeName': instance.issueTypeName,
      'subIssueNames': instance.subIssueNames,
    };
