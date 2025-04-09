import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_room_model.g.dart';

@JsonSerializable()
class ChatRoomModel {
  ChatRoomModel(
      {this.type,
      this.chatId,
      this.name,
      this.request,
      this.lastSeen,
      this.created,
      this.job,
      this.chatMode});

  String? type;
  String? chatId;
  String? name;
  EstimateRequestModel? request;
  int? lastSeen, created;
  String? status;
  JobModel? job;
  String? chatMode;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
