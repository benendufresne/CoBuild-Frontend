import 'package:json_annotation/json_annotation.dart';
part 'service_category.g.dart';

@JsonSerializable()
class ServiceCategoryModel {
  @JsonKey(name: '_id')
  String? sid;
  String? categoryIdString, serviceType, categoryName;
  ServiceCategoryModel(
      {this.sid, this.categoryIdString, this.serviceType, this.categoryName});
  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceCategoryModelToJson(this);
}
