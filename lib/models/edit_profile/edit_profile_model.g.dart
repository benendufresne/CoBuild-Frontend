// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileModel _$EditProfileModelFromJson(Map<String, dynamic> json) =>
    EditProfileModel(
      name: json['name'] as String?,
      flagCode: json['flagCode'] as String?,
      countryCode: json['countryCode'] as String?,
      mobileNo: json['mobileNo'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$EditProfileModelToJson(EditProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'flagCode': instance.flagCode,
      'countryCode': instance.countryCode,
      'mobileNo': instance.mobileNo,
      'email': instance.email,
      'location': instance.location,
    };
