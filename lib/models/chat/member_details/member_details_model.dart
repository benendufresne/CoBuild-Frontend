import 'package:json_annotation/json_annotation.dart';
part 'member_details_model.g.dart';

@JsonSerializable()
class MemberDetailsModel {
  String? id;
  String? name;
  String? userType;
  String? userName;
  String? language;
  String? status;
  String? profilePicture;
  bool? isAccountDeleted;

  MemberDetailsModel(
      {this.id,
      this.name,
      this.userType,
      this.userName,
      this.language,
      this.status,
      this.profilePicture,
      this.isAccountDeleted});

  factory MemberDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MemberDetailsModelToJson(this);
}
