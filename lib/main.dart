import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/Home.dart';
import 'package:nasooh/app/constants.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'Data/repositories/notification/firebase_notification.dart';
import 'Data/repositories/notification/local_notification.dart';
import 'Presentation/screens/welcome_screen/welcome.dart';
import 'app/keys.dart';
import 'app/utils/BlocProviders.dart';
import 'app/utils/Language/get_language.dart';
import 'app/utils/sharedPreferenceClass.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // ignore: deprecated_member_use
//   FlutterNativeSplash.removeAfter(initialization);
//   await SharedPrefs().init();
//   ////
//   runApp(const MyApp());
// }

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
//   FCMNotification().showNotification(message);
//   // if(Platform.isIOS){
//   //
//   //   AudioPlayer().play(AssetSource('sounds/synth.mp3'));
//   // }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  FlutterNativeSplash.removeAfter(initialization);
  await SharedPrefs().init();
  await Firebase.initializeApp();
  FirebaseCustomNotification.initializeFirebaseCustomNotification();

  await CustomLocalNotification.setupFlutterNotifications();

  FirebaseMessaging.onBackgroundMessage(
      FirebaseCustomNotification.firebaseMessagingBackgroundHandler);

  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FCMNotification fcmNotification = FCMNotification();

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onBackgroundMessage(
    //     FirebaseCustomNotification.firebaseMessagingBackgroundHandler);

    // Firebase.initializeApp().then((value) {
    //   fcmNotification.registerNotification();
    //   fcmNotification.configLocalNotification();
    // });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext contextt) {
    return MultiBlocProvider(
      providers: providers,
      child: GetMaterialApp(
        translations: Messages(),
        // your translations
        locale: sharedPrefs.getLanguage() == ""
            ? const Locale('ar')
            : Locale(sharedPrefs.getLanguage()),
        // translations will be displayed in that locale
        fallbackLocale: const Locale('ar'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ar'), Locale('en')],
        navigatorKey: Keys.navigatorKey,
        builder: (context2, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: false,
            mediaQueryData:
                MediaQuery.of(context2).copyWith(textScaleFactor: 1.0),
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000,
                  name: TABLET, scaleFactor: 1.3),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'MANSOU7',
        theme: ThemeData(
            primarySwatch: getMaterialColor(
                colorHex:
                    0xFFbac0085A55), // todo change color to use default app color
            appBarTheme: const AppBarTheme().copyWith(
              toolbarHeight: 70,
              titleSpacing: 4,
              color: Constants.whiteAppColor,
              elevation: 0,
              titleTextStyle: Constants.mainTitleFont,
            ),
            scaffoldBackgroundColor: Constants.whiteAppColor),
        home: const PreHome(),
      ),
    );
  }

  getMaterialColor({required int colorHex}) {
    Map<int, Color> color = {
      // ignore: use_full_hex_values_for_flutter_colors
      50: const Color.fromRGBO(0, 123, 165, .1),
      100: const Color.fromRGBO(0, 123, 165, .2),
      200: const Color.fromRGBO(0, 123, 165, .3),
      300: const Color.fromRGBO(0, 123, 165, .4),
      400: const Color.fromRGBO(0, 123, 165, .5),
      500: const Color.fromRGBO(0, 123, 165, .6),
      600: const Color.fromRGBO(0, 123, 165, .7),
      700: const Color.fromRGBO(0, 123, 165, .8),
      800: const Color.fromRGBO(0, 123, 165, .9),
      900: const Color.fromRGBO(0, 123, 165, 1),
    };
    return MaterialColor(colorHex, color);
  }
}

class PreHome extends StatefulWidget {
  const PreHome({super.key});

  @override
  State<PreHome> createState() => _PreHomeState();
}

class _PreHomeState extends State<PreHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage
        .listen(CustomLocalNotification.showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp
        .listen((CustomLocalNotification.showFlutterNotification));
  }

  @override
  Widget build(BuildContext context) {
    return sharedPrefs.getToken() != "" ? const Home() : const WelcomeScreen();
  }
}

Future<void> initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}
