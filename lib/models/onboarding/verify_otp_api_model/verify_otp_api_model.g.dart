// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpApiModel _$VerifyOtpApiModelFromJson(Map<String, dynamic> json) =>
    VerifyOtpApiModel(
      type: json['type'] as String?,
      email: json['email'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$VerifyOtpApiModelToJson(VerifyOtpApiModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'otp': instance.otp,
      'email': instance.email,
    };
