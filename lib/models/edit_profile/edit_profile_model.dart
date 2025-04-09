import 'package:cobuild/models/location_model/location_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_model.g.dart';

@JsonSerializable()
class EditProfileModel {
  EditProfileModel(
      {this.name,
      this.flagCode,
      this.countryCode,
      this.mobileNo,
      this.location,
      this.email});

  String? name, flagCode, countryCode, mobileNo, email;
  LocationModel? location;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileModelToJson(this);
}
