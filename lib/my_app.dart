import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'Data/repositories/notification/fcm.dart';
import 'Presentation/screens/Home/home.dart';
import 'Presentation/screens/welcome_screen/welcome.dart';
import 'app/keys.dart';
import 'app/style/theme.dart';
import 'app/utils/Language/get_language.dart';
import 'app/utils/bloc_providers.dart';
import 'app/utils/exports.dart';
import 'app/utils/shared_preference.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    super.initState();
    FirebaseCustomNotification.setUpFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: GestureDetector(
        onTap: () {
          if (FocusManager.instance.primaryFocus?.hasFocus == true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
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

          color: Colors.transparent,
          supportedLocales: const [Locale('ar'), Locale('en')],
          navigatorKey: Keys.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'نصوح',
          theme: themeData,
          builder: (context,child){
            return Container(
                color: Colors.white,
                child: child!,
            );
        },
          // home: const Fatorah(),
          home: sharedPrefs.getToken() != ""
              ? const HomeLayout(currentIndex: 0)
              : const WelcomeScreen(),
        ),
      ),
    );
  }
}
