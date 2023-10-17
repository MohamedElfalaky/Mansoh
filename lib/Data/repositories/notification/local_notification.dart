import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/app/keys.dart';

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
    // var msg = jsonDecode(message.notification!.body!);
    // var msg = jsonDecode(message.data["advice_id"]);
    // var msg = jsonDecode(message.data["is_chat"]);

    // print('notification response: ${msg["body"]}');
    // print('notification response: ${message.data}');
    // print('notification response: ${message.data["advice_id"]}');
    // print('notification response: ${message.data["is_chat"]}');
    // print('notification Contxt: ${Keys.navigatorKey.currentContext}');
    // print(
    //     'notification secon contxt: ${Keys.navigatorKey.currentState!.context}');
    // print('notification response: ${message.notification!.body!}');

    if (message.data["is_chat"] == "1") {
      // print("render chat");
      Keys.navigatorKey.currentState!.context
          .read<ShowAdviceCubit>()
          .getAdviceFunction(adviceId: int.parse(message.data["advice_id"]))
          .then((value) {
            // print("hello $value");
          });
    }

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
      // print('local notification ${notification.title}');
    }
  }
}
