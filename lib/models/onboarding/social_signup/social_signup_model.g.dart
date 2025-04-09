// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialSignUpModel _$SocialSignUpModelFromJson(Map<String, dynamic> json) =>
    SocialSignUpModel(
      socialLoginId: json['socialLoginId'] as String?,
      socialLoginType: json['socialLoginType'] as String,
      isEmailVerified: json['isEmailVerified'] as bool?,
      email: json['email'] as String?,
      flagCode: json['flagCode'] as String?,
      countryCode: json['countryCode'] as String?,
      mobileNo: json['mobileNo'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SocialSignUpModelToJson(SocialSignUpModel instance) =>
    <String, dynamic>{
      'socialLoginType': instance.socialLoginType,
      'socialLoginId': instance.socialLoginId,
      'isEmailVerified': instance.isEmailVerified,
      'email': instance.email,
      'flagCode': instance.flagCode,
      'countryCode': instance.countryCode,
      'mobileNo': instance.mobileNo,
      'name': instance.name,
    };
