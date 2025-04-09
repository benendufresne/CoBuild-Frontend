import 'package:cobuild/utils/enums/onboarding_enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_otp_model.g.dart';

/// Model class to verify OTP request
@JsonSerializable()
class VerifyOtpModel {
  VerifyOtpModel({this.type, this.email});
  VerifyOtpEnum? type;
  String? email;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOtpModelToJson(this);
}
