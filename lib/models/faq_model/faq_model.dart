import 'package:json_annotation/json_annotation.dart';
part 'faq_model.g.dart';

/// Model for Handling "Frequenty asked Questions" List
@JsonSerializable()
class FAQModel {
  String? question, answer;
  FAQModel({
    this.question,
    this.answer,
  });
  factory FAQModel.fromJson(Map<String, dynamic> json) =>
      _$FAQModelFromJson(json);
  Map<String, dynamic> toJson() => _$FAQModelToJson(this);
}
