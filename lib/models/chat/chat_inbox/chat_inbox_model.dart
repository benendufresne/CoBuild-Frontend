import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_inbox_model.g.dart';

@JsonSerializable()
class ChatInboxModel {
  ChatInboxModel(
      {this.sId,
      this.chatId,
      this.type,
      this.request,
      this.report,
      this.name,
      this.lastSeen,
      this.lastMessage,
      this.created,
      this.unreadMessages,
      this.lastMsgCreated,
      this.inboxStatus,
      this.chatMode,
      this.job});

  @JsonKey(name: '_id')
  String? sId;
  String? chatId;
  String? type;
  EstimateRequestModel? request;
  DamageModel? report;
  String? name;
  int? lastSeen, created;
  int? unreadMessages;
  int? lastMsgCreated;
  String? inboxStatus;
  List<MessageModel>? lastMessage;
  String? chatMode;
  JobModel? job;

  factory ChatInboxModel.fromJson(Map<String, dynamic> json) =>
      _$ChatInboxModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatInboxModelToJson(this);
}
