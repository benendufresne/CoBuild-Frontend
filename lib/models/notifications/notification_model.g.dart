// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      sId: json['_id'] as String?,
      title: json['title'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      status: json['status'] as String?,
      type: json['type'] as String?,
      created: (json['created'] as num?)?.toInt(),
      message: json['message'] as String?,
      details: json['details'] == null
          ? null
          : NotificationDetailsModel.fromJson(
              json['details'] as Map<String, dynamic>),
      reportId: json['reportId'] as String?,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'message': instance.message,
      'isRead': instance.isRead,
      'status': instance.status,
      'type': instance.type,
      'created': instance.created,
      'reportId': instance.reportId,
      'requestId': instance.requestId,
      'details': instance.details,
    };
