import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'damage_model.g.dart';

@JsonSerializable()
class DamageModel {
  @JsonKey(name: '_id')
  String? sId;
  String? type, description;
  LocationModel? location;
  List<MediaModel>? media;
  String? status;
  int? created;
  String? chatId;

  DamageModel(
      {this.type,
      this.description,
      this.location,
      this.media,
      this.status,
      this.created,
      this.sId,
      this.chatId});
  factory DamageModel.fromJson(Map<String, dynamic> json) =>
      _$DamageModelFromJson(json);
  Map<String, dynamic> toJson() => _$DamageModelToJson(this);
}
