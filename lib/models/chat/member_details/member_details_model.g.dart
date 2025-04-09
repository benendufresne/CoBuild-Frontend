// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDetailsModel _$MemberDetailsModelFromJson(Map<String, dynamic> json) =>
    MemberDetailsModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      userType: json['userType'] as String?,
      userName: json['userName'] as String?,
      language: json['language'] as String?,
      status: json['status'] as String?,
      profilePicture: json['profilePicture'] as String?,
      isAccountDeleted: json['isAccountDeleted'] as bool?,
    );

Map<String, dynamic> _$MemberDetailsModelToJson(MemberDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userType': instance.userType,
      'userName': instance.userName,
      'language': instance.language,
      'status': instance.status,
      'profilePicture': instance.profilePicture,
      'isAccountDeleted': instance.isAccountDeleted,
    };
