import 'package:json_annotation/json_annotation.dart';
part 'media_model.g.dart';

@JsonSerializable()
class MediaModel {
  String? media;
  String? mediaType;

  MediaModel({this.media, this.mediaType});
  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);
  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
