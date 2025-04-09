import 'package:json_annotation/json_annotation.dart';
part 'notification_details_model.g.dart';

@JsonSerializable()
class NotificationDetailsModel {
  NotificationDetailsModel({this.reportId, this.requestId});

  String? reportId;
  String? requestId;

  factory NotificationDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDetailsModelToJson(this);
}
