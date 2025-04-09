import 'package:json_annotation/json_annotation.dart';
part 'tutorial_model.g.dart';

@JsonSerializable()
class TutorialModel {
  TutorialModel(
      {required this.image, required this.title, required this.description});

  String image, title, description;

  factory TutorialModel.fromJson(Map<String, dynamic> json) =>
      _$TutorialModelFromJson(json);
  Map<String, dynamic> toJson() => _$TutorialModelToJson(this);
}
