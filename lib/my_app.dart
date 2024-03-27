import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/home.dart';
import 'package:nasooh/app/Style/theme.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'Presentation/screens/welcome_screen/welcome.dart';
import 'app/keys.dart';
import 'app/utils/bloc_providers.dart';
import 'app/utils/Language/get_language.dart';
import 'app/utils/shared_preference_class.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: GetMaterialApp(

        translations: Messages(),
        locale: sharedPrefs.getLanguage() == ""
            ? const Locale('ar')
            : Locale(sharedPrefs.getLanguage()),
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
            mediaQueryData: MediaQuery.of(context2)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET, scaleFactor: 1.3),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'نصوح',
        theme: themeData,
        home: sharedPrefs.getToken() != ""
            ? const HomeLayout(currentIndex: 0)
            : const WelcomeScreen(),
      ),
    );
  }
}
