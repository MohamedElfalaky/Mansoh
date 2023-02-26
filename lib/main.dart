import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nasooh/Data/cubit/authentication/login_cubit/login_cubit.dart';
import 'package:nasooh/Presentation/screens/Advisor/AdvisorScreen.dart';
import 'package:nasooh/Presentation/screens/Home/Home.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'Presentation/screens/UserProfileScreens/userProfileScreen.dart';
import 'app/global.dart';
import 'app/keys.dart';
import 'app/utils/BlocProviders.dart';
import 'app/utils/lang/demo_localization.dart';
import 'app/utils/lang/language_constants.dart';
import 'app/utils/sharedPreferenceClass.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  FlutterNativeSplash.removeAfter(initialization);
  await SharedPrefs().init();
  ////
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setAppLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setAppLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

//   // to change language
  void changeLanguage() async {
    Locale newLocale = await setLocale("ar");
    GlobalVars().oldLang = "en";
    sharedPrefs.setlanguage("ar");
    setState(() {
      GlobalVars().headers = {'Accept': 'application/json', 'lang': "ar"};
      selectedLang = "ar";

      MyApp.setLocale(context, newLocale);
    });
  }

// }
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
        selectedLang = _locale!.languageCode;
        GlobalVars().oldLang = _locale!.languageCode;
      });
    });

    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
      ],
      child: MaterialApp(
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
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale("ar", "SA"),
        // locale: _locale,
        supportedLocales: const [
          Locale("ar", "SA"),
          Locale("en", "US"),
        ],
        localeResolutionCallback: (currentLocale, supportedLocales) {
          if (currentLocale != null) {
            for (Locale locale in supportedLocales) {
              if (currentLocale.languageCode == locale.languageCode) {
                return currentLocale;
              }
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: getMaterialColor(
              colorHex:
                  0xFF0085A5), // todo change color to use default app color
        ),
        home: AdvisorScreen(),
      ),
    );
  }

  getMaterialColor({required int colorHex}) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(136, 14, 79, .1),
      100: const Color.fromRGBO(136, 14, 79, .2),
      200: const Color.fromRGBO(136, 14, 79, .3),
      300: const Color.fromRGBO(136, 14, 79, .4),
      400: const Color.fromRGBO(136, 14, 79, .5),
      500: const Color.fromRGBO(136, 14, 79, .6),
      600: const Color.fromRGBO(136, 14, 79, .7),
      700: const Color.fromRGBO(136, 14, 79, .8),
      800: const Color.fromRGBO(136, 14, 79, .9),
      900: const Color.fromRGBO(136, 14, 79, 1),
    };
    return MaterialColor(colorHex, color);
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // todo set internet subscription vars
//   late StreamSubscription<ConnectivityResult> subscription;
//   bool? isConnected;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     MyApplication.checkConnection().then((value) {
//       if (value) {
//         //////
//         // todo recall data

//       } else {
//         MyApplication.showToastView(
//             message: '${getTranslated(context, 'noInternet')}');
//       }
//     });

//     // todo subscribe to internet change
//     subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       setState(() {
//         result == ConnectivityResult.none
//             ? isConnected = false
//             : isConnected = true;
//       });

//       /// if internet comes back
//       if (result != ConnectivityResult.none) {
//         /// call your apis
//         // todo recall data
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // todo if not connected display nointernet widget else continue to the rest build code
//     final size = MediaQuery.of(context).size;
//     if (isConnected == null) {
//       MyApplication.checkConnection().then((value) {
//         setState(() {
//           isConnected = value;
//         });
//       });
//     } else if (!isConnected!) {
//       MyApplication.showToastView(
//           message: '${getTranslated(context, 'noInternet')}');
//       return NoInternetWidget(size: size);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: const Center(),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// // todo change language example
// //   // to change language
//   void changeLanguage()async{
//     Locale newLocale = await setLocale("en");
//     GlobalVars().oldLang = "ar";
//     sharedPrefs.setlanguage("en");
//     setState(() {
//       GlobalVars().headers = {
//         'Accept': 'application/json',
//         'lang': "en"
//       };
//       selectedLang = "en";

//        MyApp.setLocale(context, newLocale);

//     });

//         }
// // }

Future<void> initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}
