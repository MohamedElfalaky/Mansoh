import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nasooh/app/utils/shared_preference_class.dart';

import '../../../app/keys.dart';
import '../../cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';

class FirebaseCustomNotification {
  static final messaging = FirebaseMessaging.instance;

  static NotificationSettings? settings;

  static Future<void> firebaseMessagingAppOpen() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('Notification data: ${message.data}');
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  static Future<bool> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  static Future<void> setUpFirebase() async {
    bool notificationStatus = await requestNotificationPermission();
    FirebaseMessaging.instance.getToken().then((token) {
      sharedPrefs.setFCM(token!);
      debugPrint("FIREBASE TOKEN $token");
    }).catchError((err) {});
    if (notificationStatus) {
      await CustomLocalNotification.setupLocalNotifications();
      FirebaseMessaging.onBackgroundMessage(
          FirebaseCustomNotification.firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage
          .listen(CustomLocalNotification.showFlutterNotification);
      FirebaseMessaging.onMessageOpenedApp
          .listen((CustomLocalNotification.onMessageOpenedApp));
      // debugPrint(
      //     'FIREBASE TOKEN: ${await FirebaseMessaging.instance.getToken()}');
      // sharedPrefs.setFCM(await FirebaseMessaging.instance.getToken()??"");
    }
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class CustomLocalNotification {
  static late AndroidNotificationChannel channel;

  static bool isFlutterLocalNotificationsInitialized = false;

  static Future<void> setupLocalNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  static void showFlutterNotification(RemoteMessage message) {
    if (message.notification != null && message.notification?.android != null) {
      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            presentBanner: true,
          ),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
      debugPrint('local notification ${message.notification?.title}');

      if (message.data["is_chat"] == "1") {
        // print("render chat");
        Keys.navigatorKey.currentState!.context
            .read<ShowAdviceCubit>()
            .getAdviceFunction(adviceId: int.parse(message.data["advice_id"]))
            .then((value) {
          // print("hello $value");
        });
      }
    }
  }

  static Future<void> onMessageOpenedApp(RemoteMessage message) async {
    log('${message.data}');
    showFlutterNotification(message);
  }
}
