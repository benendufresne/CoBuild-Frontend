import 'package:json_annotation/json_annotation.dart';
part 'version_details_model.g.dart';

@JsonSerializable()
class VersionDetailsModel {
  int? id;
  String? version;
  String? platform;
  String? type;
  String? createdAt;
  String? updatedAt;
  VersionDetailsModel(
      {this.id,
      this.version,
      this.platform,
      this.type,
      this.createdAt,
      this.updatedAt});
  factory VersionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$VersionDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$VersionDetailsModelToJson(this);
}
