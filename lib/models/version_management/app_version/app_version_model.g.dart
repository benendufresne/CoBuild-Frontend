// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionModel _$AppVersionModelFromJson(Map<String, dynamic> json) =>
    AppVersionModel(
      forcefull: json['forcefull'] == null
          ? null
          : VersionDetailsModel.fromJson(
              json['forcefull'] as Map<String, dynamic>),
      normal: json['normal'] == null
          ? null
          : VersionDetailsModel.fromJson(
              json['normal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppVersionModelToJson(AppVersionModel instance) =>
    <String, dynamic>{
      'forcefull': instance.forcefull,
      'normal': instance.normal,
    };
