// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategoryModel _$ServiceCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ServiceCategoryModel(
      sid: json['_id'] as String?,
      categoryIdString: json['categoryIdString'] as String?,
      serviceType: json['serviceType'] as String?,
      categoryName: json['categoryName'] as String?,
    );

Map<String, dynamic> _$ServiceCategoryModelToJson(
        ServiceCategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.sid,
      'categoryIdString': instance.categoryIdString,
      'serviceType': instance.serviceType,
      'categoryName': instance.categoryName,
    };
