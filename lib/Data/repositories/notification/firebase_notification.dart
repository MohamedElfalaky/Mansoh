import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:nasooh/Data/repositories/notification/local_notification.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';

class FirebaseCustomNotification {
  static final messaging = FirebaseMessaging.instance;
  static String? token;

  static NotificationSettings? settings;

  static void initializeFirebaseCustomNotification() {
    _initializeSettings();
    _initializeToken();
  }

  static Future<void> firebaseMessagingForegroundHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Notification foreground message: ${message.messageId}');

        print('Notification foreground data: ${message.data}');
        print('token $token');
      }
    });
  }

  static Future<void> firebaseMessagingAppOpen() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Notification foreground message: ${message.messageId}');
        print('Notification foreground data: ${message.data}');
        print('hellloooooooooo: ${message.notification.toString()}');

        print('token $token');
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print(
        "Notification background message: ${message.notification?.title ?? ""}");
    print('hellloooooooooo: ${message.notification.toString()}');

    // CustomLocalNotification.showFlutterNotification(message);
  }

  static Future<void> _initializeSettings() async {
    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> _initializeToken() async {
    token = await FirebaseMessaging.instance.getToken();
    sharedPrefs.setFCM(token!);
    print("token $token ");
  }
}
