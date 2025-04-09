import 'package:json_annotation/json_annotation.dart';
part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {
  SignupModel({
    required this.email,
    required this.countryCode,
    required this.mobileNo,
    required this.flagCode,
    this.socialLoginId,
    this.password,
  });

  String email, countryCode, mobileNo, flagCode;
  String? socialLoginId, password;

  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
