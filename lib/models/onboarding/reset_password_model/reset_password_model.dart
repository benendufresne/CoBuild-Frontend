import 'package:json_annotation/json_annotation.dart';
part 'reset_password_model.g.dart';

@JsonSerializable()
class ResetPasswordModel {
  ResetPasswordModel(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  String email, password, confirmPassword;

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
}
