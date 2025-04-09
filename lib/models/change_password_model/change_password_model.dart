import 'package:json_annotation/json_annotation.dart';
part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModel {
  ChangePasswordModel({this.oldPassword, this.password, this.confirmPassword});

  String? oldPassword, password, confirmPassword;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordModelToJson(this);
}
