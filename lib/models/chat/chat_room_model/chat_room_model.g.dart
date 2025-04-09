// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) =>
    ChatRoomModel(
      type: json['type'] as String?,
      chatId: json['chatId'] as String?,
      name: json['name'] as String?,
      request: json['request'] == null
          ? null
          : EstimateRequestModel.fromJson(
              json['request'] as Map<String, dynamic>),
      lastSeen: (json['lastSeen'] as num?)?.toInt(),
      created: (json['created'] as num?)?.toInt(),
      job: json['job'] == null
          ? null
          : JobModel.fromJson(json['job'] as Map<String, dynamic>),
      chatMode: json['chatMode'] as String?,
    )..status = json['status'] as String?;

Map<String, dynamic> _$ChatRoomModelToJson(ChatRoomModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'chatId': instance.chatId,
      'name': instance.name,
      'request': instance.request,
      'lastSeen': instance.lastSeen,
      'created': instance.created,
      'status': instance.status,
      'job': instance.job,
      'chatMode': instance.chatMode,
    };
