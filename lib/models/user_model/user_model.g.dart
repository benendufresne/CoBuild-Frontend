// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      accessToken: json['accessToken'] as String?,
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      mobileNo: json['mobileNo'] as String?,
      countryCode: json['countryCode'] as String?,
      isMobileVerified: json['isMobileVerified'] as bool?,
      userType: json['userType'] as String?,
      email: json['email'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isProfileCompleted: json['isProfileCompleted'] as bool?,
      flagCode: json['flagCode'] as String?,
      status: json['status'] as String?,
      created: (json['created'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      notification: json['notification'] as bool?,
      allnotificationsSeen: json['allnotificationsSeen'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'name': instance.name,
      'userId': instance.userId,
      'mobileNo': instance.mobileNo,
      'countryCode': instance.countryCode,
      'isMobileVerified': instance.isMobileVerified,
      'userType': instance.userType,
      'email': instance.email,
      'isEmailVerified': instance.isEmailVerified,
      'isProfileCompleted': instance.isProfileCompleted,
      'flagCode': instance.flagCode,
      'status': instance.status,
      'created': instance.created,
      'location': instance.location,
      'notification': instance.notification,
      'allnotificationsSeen': instance.allnotificationsSeen,
    };
