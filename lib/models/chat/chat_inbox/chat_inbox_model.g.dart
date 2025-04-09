// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_inbox_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatInboxModel _$ChatInboxModelFromJson(Map<String, dynamic> json) =>
    ChatInboxModel(
      sId: json['_id'] as String?,
      chatId: json['chatId'] as String?,
      type: json['type'] as String?,
      request: json['request'] == null
          ? null
          : EstimateRequestModel.fromJson(
              json['request'] as Map<String, dynamic>),
      report: json['report'] == null
          ? null
          : DamageModel.fromJson(json['report'] as Map<String, dynamic>),
      name: json['name'] as String?,
      lastSeen: (json['lastSeen'] as num?)?.toInt(),
      lastMessage: (json['lastMessage'] as List<dynamic>?)
          ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      created: (json['created'] as num?)?.toInt(),
      unreadMessages: (json['unreadMessages'] as num?)?.toInt(),
      lastMsgCreated: (json['lastMsgCreated'] as num?)?.toInt(),
      inboxStatus: json['inboxStatus'] as String?,
      chatMode: json['chatMode'] as String?,
      job: json['job'] == null
          ? null
          : JobModel.fromJson(json['job'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatInboxModelToJson(ChatInboxModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'chatId': instance.chatId,
      'type': instance.type,
      'request': instance.request,
      'report': instance.report,
      'name': instance.name,
      'lastSeen': instance.lastSeen,
      'created': instance.created,
      'unreadMessages': instance.unreadMessages,
      'lastMsgCreated': instance.lastMsgCreated,
      'inboxStatus': instance.inboxStatus,
      'lastMessage': instance.lastMessage,
      'chatMode': instance.chatMode,
      'job': instance.job,
    };
