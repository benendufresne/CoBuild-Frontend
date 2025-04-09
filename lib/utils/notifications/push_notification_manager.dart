import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cobuild/bloc/controller/notification_bloc/notification_controller.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/notifications/notification_model.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Class to  handle notificaiton related data

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationModel model = NotificationModel.fromJson(message.data);
  navigateNotificationToDetailsPage(model);
  printCustom("Background Notification coming ------");
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.payload?.isNotEmpty ?? false) {
    Map<String, dynamic> data = jsonDecode(notificationResponse.payload ?? '');
    NotificationModel model = NotificationModel.fromJson(data);
    navigateNotificationToDetailsPage(model);
    printCustom(
        "hanlde local notification terminated ${notificationResponse.payload}");
  }
  // handle action
}

class PushNotificationsManager {
  static late PushNotificationsManager _appPreferences;
  static int notificationCount = 0;
  static String deviceId = 'temp_deviceId';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String deviceToken = "";
  PushNotificationsManager._internal();

  factory PushNotificationsManager() {
    _appPreferences = PushNotificationsManager._internal();
    return _appPreferences;
  }

  void resetNotificationCount() {
    notificationCount = 0;
  }

  Future<void> init() async {
    try {
      await _requestNotificationPermission();
      await _getId();
      await _setDeviceToken();
      await _initializeLocalNotification();
      _notificationConfigure();
      _firebaseMessaging.getInitialMessage().then((message) {
        if (message != null) {
          return _navigateToNotificationScreen(message: message.data);
        }
      });
    } catch (e) {
      printCustom("Exception in init notification $e");
    }
  }

  // Request notification permission
  Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
    );
    printCustom('Permission granted: ${settings.authorizationStatus}');
  }

//get unique id of ios and android
  _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id; // unique ID on Android
    }
    if (deviceId.isEmpty) {
      deviceId = 'temp_deviceId';
    }
    AppPreferences.setDeviceId(deviceId);
  }

  // Get FCM token
  Future<void> _setDeviceToken() async {
    try {
      deviceToken = 'temp_deviceToken';
      String? token = await _firebaseMessaging.getToken();
      if (token?.isNotEmpty ?? false) {
        deviceToken = token ?? '';
      }
      printCustom("deviceToken $deviceToken");
      AppPreferences.setDeviceToken(deviceToken);
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        deviceToken = token;
        AppPreferences.setDeviceToken(deviceToken);
      });
    } catch (e) {
      printCustom('Error fetching token: $e');
    }
  }

  // Initialize local notification settings
  Future<void> _initializeLocalNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("notification_icon_image");
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      dynamic data = notificationResponse.payload;
      // Handle notification response here
      _navigateToNotificationScreen(delay: false, message: jsonDecode(data));
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  _notificationConfigure() {
    _handleForegroundMessages();
    _handleBackgroundMessages();
    _handleTerminatedMessages();
  }

  // Handle foreground messages
  void _handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      printCustom("foreground message is : - ${message.toMap()}");
      printCustom(message.notification?.body.toString());
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  // Handle While clicked on a notification :-
  void _handleBackgroundMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _navigateToNotificationScreen(message: message.data);
    });
  }

  // Handle terminated messages
  void _handleTerminatedMessages() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    //To enable foreground notification for iOS
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'CoBuild',
      'channel',
      description: 'description.',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: channel.importance,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      enableVibration: true,
      icon: 'notification_icon_image',
      color: AppColors.primaryColor,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
        5, // Notification ID
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: jsonEncode(message.data));
    if (ctx.mounted) {
      ctx
          .read<NotificationsController>()
          .add(const ReceivedNewNotificationEvent());
    }
  }

  /// On click of notification from notification Trey
  _navigateToNotificationScreen(
      {bool delay = true, required Map<String, dynamic> message}) {
    NotificationModel model = NotificationModel.fromJson(message);
    if (AppPreferences.isLoggedIn) {
      DeBouncer deBouncer = DeBouncer(milliseconds: delay ? 2000 : 0);
      deBouncer.run(() {
        navigateNotificationToDetailsPage(model);
      });
    }
  }

  void removeAllLocalNotifications() =>
      _flutterLocalNotificationsPlugin.cancelAll();
}
