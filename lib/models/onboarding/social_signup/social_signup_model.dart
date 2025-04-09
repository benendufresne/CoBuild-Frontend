import 'package:json_annotation/json_annotation.dart';
part 'social_signup_model.g.dart';

/// Model class to hanlde Social Signup Model
@JsonSerializable()
class SocialSignUpModel {
  String socialLoginType;
  String? socialLoginId;
  bool? isEmailVerified;
  String? email, flagCode, countryCode, mobileNo;
  String? name;
  SocialSignUpModel(
      {this.socialLoginId,
      required this.socialLoginType,
      this.isEmailVerified,
      this.email,
      this.flagCode,
      this.countryCode,
      this.mobileNo,
      this.name});
  factory SocialSignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SocialSignUpModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialSignUpModelToJson(this);
}
