// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_estimate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateRequestModel _$EstimateRequestModelFromJson(
        Map<String, dynamic> json) =>
    EstimateRequestModel(
      categoryName: json['categoryName'] as String?,
      categoryId: json['categoryId'] as String?,
      categoryIdString: json['categoryIdString'] as String?,
      serviceType: json['serviceType'] as String?,
      issueTypeName: json['issueTypeName'] as String?,
      subIssueName: json['subIssueName'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      media: json['media'] as String?,
      mediaType: json['mediaType'] as String?,
      created: (json['created'] as num?)?.toInt(),
      sId: json['_id'] as String?,
      status: json['status'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      estimatedDays: json['estimatedDays'] as String?,
      reqId: json['reqId'] as String?,
      chatId: json['chatId'] as String?,
    );

Map<String, dynamic> _$EstimateRequestModelToJson(
        EstimateRequestModel instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
      'categoryIdString': instance.categoryIdString,
      'issueTypeName': instance.issueTypeName,
      'subIssueName': instance.subIssueName,
      'name': instance.name,
      'location': instance.location,
      'description': instance.description,
      'media': instance.media,
      'mediaType': instance.mediaType,
      'chatId': instance.chatId,
      '_id': instance.sId,
      'reqId': instance.reqId,
      'created': instance.created,
      'status': instance.status,
      'estimatedDays': instance.estimatedDays,
      'amount': instance.amount,
    };
