import 'package:cobuild/models/location_model/location_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  JobModel(
      {this.sId,
      this.title,
      this.categoryId,
      this.personalName,
      this.email,
      this.location,
      this.companyLocation,
      this.fullMobileNo,
      this.aboutCompany,
      this.priority,
      this.procedure,
      this.jobIdString,
      this.status,
      this.doorTag,
      this.created,
      this.schedule,
      this.categoryName,
      this.serviceType,
      serviceTypeId});

  @JsonKey(name: '_id')
  String? sId;
  String? title;
  String? categoryId;
  String? personalName, email;
  LocationModel? location, companyLocation;
  String? fullMobileNo;
  String? aboutCompany;
  String? priority;
  String? procedure;
  String? jobIdString;
  String? status;
  String? doorTag;
  int? created;
  int? schedule;
  String? categoryName;
  String? serviceType, serviceTypeId;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
