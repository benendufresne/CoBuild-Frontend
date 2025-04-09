// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDetailsModel _$VersionDetailsModelFromJson(Map<String, dynamic> json) =>
    VersionDetailsModel(
      id: (json['id'] as num?)?.toInt(),
      version: json['version'] as String?,
      platform: json['platform'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$VersionDetailsModelToJson(
        VersionDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'platform': instance.platform,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
