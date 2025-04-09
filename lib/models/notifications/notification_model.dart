import 'package:cobuild/models/notifications/notificaiton_details_model/notification_details_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  NotificationModel(
      {this.sId,
      this.title,
      this.isRead = false,
      this.status,
      this.type,
      this.created,
      this.message,
      this.details,
      this.reportId,
      this.requestId});

  @JsonKey(name: '_id')
  String? sId;
  String? title, message;
  bool isRead;
  String? status, type;
  int? created;
  String? reportId, requestId;
  NotificationDetailsModel? details;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
