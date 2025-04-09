// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      sId: json['_id'] as String?,
      title: json['title'] as String?,
      categoryId: json['categoryId'] as String?,
      personalName: json['personalName'] as String?,
      email: json['email'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      companyLocation: json['companyLocation'] == null
          ? null
          : LocationModel.fromJson(
              json['companyLocation'] as Map<String, dynamic>),
      fullMobileNo: json['fullMobileNo'] as String?,
      aboutCompany: json['aboutCompany'] as String?,
      priority: json['priority'] as String?,
      procedure: json['procedure'] as String?,
      jobIdString: json['jobIdString'] as String?,
      status: json['status'] as String?,
      doorTag: json['doorTag'] as String?,
      created: (json['created'] as num?)?.toInt(),
      schedule: (json['schedule'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      serviceType: json['serviceType'] as String?,
      serviceTypeId: json['serviceTypeId'],
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'categoryId': instance.categoryId,
      'personalName': instance.personalName,
      'email': instance.email,
      'location': instance.location,
      'companyLocation': instance.companyLocation,
      'fullMobileNo': instance.fullMobileNo,
      'aboutCompany': instance.aboutCompany,
      'priority': instance.priority,
      'procedure': instance.procedure,
      'jobIdString': instance.jobIdString,
      'status': instance.status,
      'doorTag': instance.doorTag,
      'created': instance.created,
      'schedule': instance.schedule,
      'categoryName': instance.categoryName,
      'serviceType': instance.serviceType,
      'serviceTypeId': instance.serviceTypeId,
    };
