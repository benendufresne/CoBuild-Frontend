// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      sid: json['_id'] as String?,
      localMessageId: json['localMessageId'] as String?,
      senderId: json['senderId'] as String?,
      chatId: json['chatId'] as String?,
      message: json['message'] as String?,
      messageType: json['messageType'] as String?,
      isRead:
          (json['isRead'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isDelivered: (json['isDelivered'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      created: (json['created'] as num?)?.toInt(),
      messageLocalStatus: json['messageLocalStatus'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      estimatedDays: json['estimatedDays'] as String?,
      notes: json['notes'] as String?,
      request: json['request'] == null
          ? null
          : EstimateRequestModel.fromJson(
              json['request'] as Map<String, dynamic>),
      messageId: json['messageId'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.sid,
      'senderId': instance.senderId,
      'chatId': instance.chatId,
      'message': instance.message,
      'messageType': instance.messageType,
      'isRead': instance.isRead,
      'isDelivered': instance.isDelivered,
      'status': instance.status,
      'created': instance.created,
      'localMessageId': instance.localMessageId,
      'messageLocalStatus': instance.messageLocalStatus,
      'estimatedDays': instance.estimatedDays,
      'amount': instance.amount,
      'notes': instance.notes,
      'request': instance.request,
      'messageId': instance.messageId,
    };
