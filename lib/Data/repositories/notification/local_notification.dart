import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Data/models/advice_screen_models/show_advice_model.dart';
import 'package:nasooh/Data/models/advisor_profile_model/advisor_profile.dart';
import 'package:nasooh/Data/repositories/show_advice_repos/show_advice_repo.dart';
import 'package:nasooh/Presentation/screens/chat_screen/chat_screen.dart';
import 'package:nasooh/app/keys.dart';
import 'package:nasooh/app/utils/myApplication.dart';

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

  static void showFlutterNotification(RemoteMessage message) async {
    var msg = jsonDecode(message.notification!.body!);

    print('notification response: ${msg["body"]}');
    print('notification response: ${msg["advice_id"]}');
    print('notification response: ${msg["is_chat"]}');
    print('notification Contxt: ${Keys.navigatorKey.currentContext}');
    print(
        'notification secon contxt: ${Keys.navigatorKey.currentState!.context}');
    print('notification response: ${message.notification!.body!}');

    if (Keys.navigatorKey.currentState!.context != null &&
        msg["is_chat"] == 1) {
      Keys.navigatorKey.currentState!.context
          .read<ShowAdviceCubit>()
          .getAdviceFunction(adviceId: msg["advice_id"])
          .then((value) => print("hello $value"));
    }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        msg["body"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'app_icon',
          ),
        ),
      );

      // flutterLocalNotificationsPlugin.initialize(InitializationSettings(),
      //     onDidReceiveNotificationResponse: (details) {
      //   if ({msg["is_chat"]} == 1) {
      //     MyApplication.navigateTo(
      //         context!,
      //         ChatScreen(
      //             showAdviceData: ShowAdviceData(
      //                 id: msg["advice_id"], adviser: AdviserProfileData())));
      //   }
      // });
      print('local notification ${notification.title}');
    }
  }
}
