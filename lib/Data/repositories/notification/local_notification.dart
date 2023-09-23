import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Data/repositories/show_advice_repos/show_advice_repo.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class CustomLocalNotification {
  static late AndroidNotificationChannel channel;

  static bool isFlutterLocalNotificationsInitialized = false;

  static Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  static void showFlutterNotification(
      {required RemoteMessage message, BuildContext? context}) async {
    print('notification response: ${message.data!["advice_id"]}');
    await ShowAdviceRepo().getAdvice(adviceId: 250);

    if (context != null)
      context
          .read<ShowAdviceCubit>()
          .getAdviceFunction(adviceId: 250)
          .then((value) => print("hello $value"));

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'app_icon',
          ),
        ),
      );
      print('local notification ${notification.title}');
    }
  }
}
