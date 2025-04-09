import 'package:json_annotation/json_annotation.dart';
part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  LocationModel({this.placeId, this.address, this.coordinates});

  @JsonKey(includeToJson: false)
  String? placeId;
  List<double>? coordinates;
  String? address;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
