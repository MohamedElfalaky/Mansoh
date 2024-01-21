// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../../../app/keys.dart';
// import '../../../app/utils/sharedPreferenceClass.dart';
// import '../../cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
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
//     // FirebaseMessaging.onBackgroundMessage(
//     //     (message) async {
//     //       return {print('hhhhhhhhhhhhhh')};
//     //     });
//     // FirebaseMessaging.onBackgroundMessage(
//     //         (message) {
//     //       showNotification(message);
//     //       // return ;
//     //     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       showNotification(message);
//       return;
//     });
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
//
//     ///==========from here this is the new ===================
//
//     var msg = jsonDecode(remoteNotification!.notification!.body!);
//     // var msg = jsonDecode(message.data["advice_id"]);
//     // var msg = jsonDecode(message.data["is_chat"]);
//
//     // print('notification response: ${msg["body"]}');
//     // print('notification response: ${message.data}');
//     // print('notification response: ${message.data["advice_id"]}');
//     // print('notification response: ${message.data["is_chat"]}');
//     // print('notification Contxt: ${Keys.navigatorKey.currentContext}');
//     // print(
//     //     'notification secon contxt: ${Keys.navigatorKey.currentState!.context}');
//     // print('notification response: ${message.notification!.body!}');
//
//     if (remoteNotification.data["is_chat"] == "1") {
//       // print("render chat");
//       Keys.navigatorKey.currentState!.context
//           .read<ShowAdviceCubit>()
//           .getAdviceFunction(adviceId: int.parse(remoteNotification.data["advice_id"]))
//           .then((value) {
//         // print("hello $value");
//       });
//     }
//
//     ///==========from here this is the new ===================
//
//     RemoteNotification? notification = remoteNotification?.notification;
//
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
//     // NotificationDetails platformChannelSpecifics = NotificationDetails(
//     //     android: androidPlatformChannelSpecifics,
//     //     iOS: darwinNotificationDetails);
//     if (notification != null) {
//       await flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               Platform.isAndroid
//                   ? 'com.dfa.flutterchatdemo'
//                   : 'com.duytq.flutterchatdemo',
//               'Flutter chat demo',
//               // channelDescription: "channel.description",
//               icon: 'app_icon',
//               playSound: true,
//               sound: const RawResourceAndroidNotificationSound('synth'),
//               enableVibration: true,
//               importance: Importance.max,
//               priority: Priority.high,
//             ),
//           ));
//       if (Keys.navigatorKey.currentState != null) {
//         // print (remoteNotification.data["text"]);
//         // print (remoteNotification.data["title"]);
//         // BlocProvider.of<ListOrdersCubit>(navigatorKey.currentState!.context)
//         //     .listAllOrders(false);
//       }
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



import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';

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
      print("FIREBASE TOKEN $token");
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
          iOS: DarwinNotificationDetails(
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