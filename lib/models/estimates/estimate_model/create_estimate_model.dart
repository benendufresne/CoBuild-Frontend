import 'package:cobuild/models/location_model/location_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_estimate_model.g.dart';

@JsonSerializable()
class EstimateRequestModel {
  EstimateRequestModel(
      {this.categoryName,
      this.categoryId,
      this.categoryIdString,
      this.serviceType,
      this.issueTypeName,
      this.subIssueName,
      this.description,
      this.name,
      this.location,
      this.media,
      this.mediaType,
      this.created,
      this.sId,
      this.status,
      this.amount,
      this.estimatedDays,
      this.reqId,
      this.chatId});
  // Top level main service type
  String? serviceType;

  /// 2nd level => Sub category
  String? categoryName, categoryId, categoryIdString;
  // ----- ///

  // iii.If service type is Cable Consulting Type :-
  String? issueTypeName, subIssueName;
  // --- ////

  /// Common for all types
  String? name;
  LocationModel? location;
  String? description;
  String? media, mediaType;
  String? chatId;

  /// Data for created Models
  @JsonKey(name: '_id')
  String? sId;
  String? reqId;
  int? created;
  String? status;
  String? estimatedDays;
  double? amount;

  factory EstimateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EstimateRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateRequestModelToJson(this);
}
