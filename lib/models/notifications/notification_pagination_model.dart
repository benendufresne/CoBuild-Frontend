import 'package:cobuild/models/notifications/notification_model.dart';

class NotificationsListPaginationModel {
  List<NotificationModel> models;
  int nextHit;
  int totalJobCount;

  NotificationsListPaginationModel(
      {required this.models, required this.nextHit, this.totalJobCount = 0});
}
