// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpModel _$VerifyOtpModelFromJson(Map<String, dynamic> json) =>
    VerifyOtpModel(
      type: $enumDecodeNullable(_$VerifyOtpEnumEnumMap, json['type']),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$VerifyOtpModelToJson(VerifyOtpModel instance) =>
    <String, dynamic>{
      'type': _$VerifyOtpEnumEnumMap[instance.type],
      'email': instance.email,
    };

const _$VerifyOtpEnumEnumMap = {
  VerifyOtpEnum.signupEmail: 'signupEmail',
  VerifyOtpEnum.forgotPassword: 'forgotPassword',
};
