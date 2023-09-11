// // ignore_for_file: avoid_print
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../../../app/keys.dart';
// import '../../../app/utils/sharedPreferenceClass.dart';
//
// class FCMNotification {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   void registerNotification() async {
//     firebaseMessaging.requestPermission();
//     firebaseMessaging.getToken().then((token) {
//       sharedPrefs.setFCM(token!);
//       print("the token falaky is $token");
//     }).catchError((err) {});
//
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         showNotification(message);
//       }
//     });
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         print('l');
//       }
//     });
//     FirebaseMessaging.onBackgroundMessage(
//         (message) async => {print('hhhhhhhhhhhhhh')});
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showNotification(message);
//       return;
//     });
//   }
//
//   Future? showNotification(RemoteMessage? remoteNotification) async {
//     print("Notification Data: ${remoteNotification?.data}");
//     print("Notification Title: ${remoteNotification?.data["title"]}");
//     print("Notification Text: ${remoteNotification?.data["text"]}");
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       Platform.isAndroid
//           ? 'com.dfa.flutterchatdemo'
//           : 'com.duytq.flutterchatdemo',
//       'Flutter chat demo',
//       playSound: true,
//       sound: const RawResourceAndroidNotificationSound('synth'),
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     if (Platform.isAndroid) {
//       const AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         importance: Importance.max,
//       );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//     }
//     DarwinNotificationDetails darwinNotificationDetails =
//         const DarwinNotificationDetails(
//             presentSound: true, presentBadge: true, presentAlert: true);
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: darwinNotificationDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       remoteNotification!.data["text"],
//       remoteNotification.data["title"],
//       platformChannelSpecifics,
//       payload: null,
//     );
//     if(Keys.navigatorKey.currentState != null) {
//       print (remoteNotification.data["text"]);
//       print (remoteNotification.data["title"]);
//       // BlocProvider.of<ListOrdersCubit>(navigatorKey.currentState!.context)
//       //     .listAllOrders(false);
//     }
//   }
//
//   void configLocalNotification() {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('app_icon');
//     const DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );
//     InitializationSettings initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsDarwin);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
// }

//// ignore_for_file: avoid_print


import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../app/keys.dart';
import '../../../app/utils/sharedPreferenceClass.dart';

class FCMNotification {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void registerNotification() async {
    firebaseMessaging.requestPermission();
    firebaseMessaging.getToken().then((token) {
      sharedPrefs.setFCM(token!);
      print("the token falaky is $token");
    }).catchError((err) {});

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        showNotification(message);
      }
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('l');
      }
    });
    FirebaseMessaging.onBackgroundMessage(
        (message) async => {print('hhhhhhhhhhhhhh')});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
      return;
    });
  }

  Future? showNotification(RemoteMessage? remoteNotification) async {
    print("Notification Data: ${remoteNotification?.data}");
    print("Notification Title: ${remoteNotification?.data["title"]}");
    print("Notification Text: ${remoteNotification?.data["text"]}");
    RemoteNotification? notification = remoteNotification?.notification;

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('synth'),
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentSound: true, presentBadge: true, presentAlert: true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // NotificationDetails platformChannelSpecifics = NotificationDetails(
    //     android: androidPlatformChannelSpecifics,
    //     iOS: darwinNotificationDetails);
    if (notification != null ) {

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
        notification.title,
        notification.body,
               NotificationDetails(
          android: AndroidNotificationDetails(
            Platform.isAndroid
                ? 'com.dfa.flutterchatdemo'
                : 'com.duytq.flutterchatdemo',
            'Flutter chat demo',
            // channelDescription: "channel.description",
            icon: 'app_icon',
            playSound: true,
            sound:  const RawResourceAndroidNotificationSound('synth'),
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high,
          ),
    ));
    if(Keys.navigatorKey.currentState != null) {
      // print (remoteNotification.data["text"]);
      // print (remoteNotification.data["title"]);
      // BlocProvider.of<ListOrdersCubit>(navigatorKey.currentState!.context)
      //     .listAllOrders(false);
    }}
  }

  void configLocalNotification() {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}