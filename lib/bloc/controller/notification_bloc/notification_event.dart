import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/notifications/notification_model.dart';

abstract class NotificationsEvent extends BlocEvent {
  const NotificationsEvent();
}

class NotificationsInitialEvent extends NotificationsEvent {
  const NotificationsInitialEvent();
}

class GetNotificationsEvent extends NotificationsEvent {
  final bool isNextPage;
  int pageNo;
  GetNotificationsEvent({
    this.isNextPage = false,
    this.pageNo = 1,
  });
}

class DeleteNotificationEvent extends NotificationsEvent {
  final NotificationModel model;
  const DeleteNotificationEvent({required this.model});
}

class ClearAllNotificationsEvent extends NotificationsEvent {
  const ClearAllNotificationsEvent();
}

class ReadNotificationEvent extends NotificationsEvent {
  final NotificationModel model;
  const ReadNotificationEvent({required this.model});
}

class ReceivedNewNotificationEvent extends NotificationsEvent {
  const ReceivedNewNotificationEvent();
}

class MarkAllNotificationsAsSeenEvent extends NotificationsEvent {
  const MarkAllNotificationsAsSeenEvent();
}

class DeleteNotificationsDataOnLogoutEvent extends NotificationsEvent {
  const DeleteNotificationsDataOnLogoutEvent();
}
