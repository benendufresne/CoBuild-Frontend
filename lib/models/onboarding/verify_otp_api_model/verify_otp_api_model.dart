import 'package:json_annotation/json_annotation.dart';
part 'verify_otp_api_model.g.dart';

/// Model class to verify OTP request
@JsonSerializable()
class VerifyOtpApiModel {
  VerifyOtpApiModel({this.type, this.email, this.otp});
  String? type, otp, email;

  factory VerifyOtpApiModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOtpApiModelToJson(this);
}
