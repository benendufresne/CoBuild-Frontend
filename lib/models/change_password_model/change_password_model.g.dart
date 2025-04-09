// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordModel _$ChangePasswordModelFromJson(Map<String, dynamic> json) =>
    ChangePasswordModel(
      oldPassword: json['oldPassword'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$ChangePasswordModelToJson(
        ChangePasswordModel instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
