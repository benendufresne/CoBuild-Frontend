import 'package:cobuild/models/location_model/location_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? accessToken, name;
  String? userId;
  String? mobileNo;
  String? countryCode;
  bool? isMobileVerified;
  String? userType;
  String? email;
  bool? isEmailVerified;
  bool? isProfileCompleted;
  String? flagCode;
  String? status;
  int? created;
  LocationModel? location;
  bool? notification;
  bool? allnotificationsSeen;

  UserModel(
      {this.accessToken,
      this.name,
      this.userId,
      this.mobileNo,
      this.countryCode,
      this.isMobileVerified,
      this.userType,
      this.email,
      this.isEmailVerified,
      this.isProfileCompleted,
      this.flagCode,
      this.status,
      this.created,
      this.location,
      this.notification,
      this.allnotificationsSeen});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
