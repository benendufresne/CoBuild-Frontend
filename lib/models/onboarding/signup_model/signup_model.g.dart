// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
      email: json['email'] as String,
      countryCode: json['countryCode'] as String,
      mobileNo: json['mobileNo'] as String,
      flagCode: json['flagCode'] as String,
      socialLoginId: json['socialLoginId'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'countryCode': instance.countryCode,
      'mobileNo': instance.mobileNo,
      'flagCode': instance.flagCode,
      'socialLoginId': instance.socialLoginId,
      'password': instance.password,
    };
