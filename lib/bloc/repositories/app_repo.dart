import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_event.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/bloc/repositories/notifications_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/notifications/push_notification_manager.dart';
import 'package:cobuild/utils/services/socket/socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRepository {
  static _AppRepositoryImpl? _instance;

  factory AppRepository() {
    return _instance ??= _AppRepositoryImpl();
  }

  Future<void> clearDataOnLogout();
}

class _AppRepositoryImpl implements AppRepository {
  final GlobalRepository _globalRepository = GlobalRepository();
  final JobsRepository _jobRepository = JobsRepository();
  // Estimate
  final EstimateRepository _estimateRepository = EstimateRepository();
  // Notification
  final NotificationsRepository _notificationsRepository =
      NotificationsRepository();
  @override
  Future<void> clearDataOnLogout() async {
    _globalRepository.clearDataOnLogout();
    _jobRepository.clearDataOnLogout();
    _estimateRepository.clearDataOnLogout();
    _notificationsRepository.clearDataOnLogout();
    PushNotificationsManager().removeAllLocalNotifications();
    AppSocketService().disconnectSocket();
    ctx.read<ChatInboxController>().add(ClearChatDataOnLogoutEvent());
  }
}
