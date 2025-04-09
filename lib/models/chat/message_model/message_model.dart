import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  MessageModel(
      {this.sid,
      this.localMessageId,
      this.senderId,
      this.chatId,
      this.message,
      this.messageType,
      this.isRead,
      this.isDelivered,
      this.status,
      this.created,
      this.messageLocalStatus,
      this.amount,
      this.estimatedDays,
      this.notes,
      this.request,
      this.messageId});

  @JsonKey(name: '_id')
  String? sid;
  String? senderId, chatId, message, messageType;
  List<String>? isRead;
  List<String>? isDelivered;
  String? status;
  int? created;
  String? localMessageId;
  String? messageLocalStatus;
  // Quotation details
  String? estimatedDays;
  int? amount;
  String? notes;
  EstimateRequestModel? request;
  // Quotation Reply
  String? messageId;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
