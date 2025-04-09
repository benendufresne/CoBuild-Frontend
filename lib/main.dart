import 'dart:io';

import 'package:cobuild/cobuild.dart';
import 'package:cobuild/deeplink_manager.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/notifications/push_notification_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Start of flutter
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await initResources();
  }
  runApp(const CoBuild());
}

Future<void> initResources() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Future.delayed(const Duration(seconds: 2));
  await AppPreferences().init();
  await Firebase.initializeApp();
  DeeplinkManager().handleDeepLink();
  PushNotificationsManager().init();
}
