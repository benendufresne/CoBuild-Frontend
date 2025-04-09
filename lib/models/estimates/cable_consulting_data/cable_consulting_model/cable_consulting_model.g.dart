// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cable_consulting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CableConsultingModel _$CableConsultingModelFromJson(
        Map<String, dynamic> json) =>
    CableConsultingModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => TopLevelCableConsultingIssueModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CableConsultingModelToJson(
        CableConsultingModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
