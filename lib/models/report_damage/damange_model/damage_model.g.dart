// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DamageModel _$DamageModelFromJson(Map<String, dynamic> json) => DamageModel(
      type: json['type'] as String?,
      description: json['description'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      created: (json['created'] as num?)?.toInt(),
      sId: json['_id'] as String?,
      chatId: json['chatId'] as String?,
    );

Map<String, dynamic> _$DamageModelToJson(DamageModel instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'type': instance.type,
      'description': instance.description,
      'location': instance.location,
      'media': instance.media,
      'status': instance.status,
      'created': instance.created,
      'chatId': instance.chatId,
    };
