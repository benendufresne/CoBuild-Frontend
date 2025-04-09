import 'package:cobuild/models/version_management/version_details/version_details_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_version_model.g.dart';

/// Model To check if new app version is available to update
@JsonSerializable()
class AppVersionModel {
  VersionDetailsModel? forcefull;
  VersionDetailsModel? normal;
  AppVersionModel({
    this.forcefull,
    this.normal,
  });
  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);
}
