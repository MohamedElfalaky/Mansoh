import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sharedPreferenceClass.dart';
import 'demo_localization.dart';

const String ENGLISH = 'en';

const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String localeStr = Platform.localeName.split("_").removeAt(0);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LAGUAGE_CODE) ?? localeStr;
  return _locale(languageCode); //todo replace language code with languageCode
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, 'US');

    case ARABIC:
      return const Locale(ARABIC, "SA");

    default:
      return const Locale(ENGLISH, 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key);
}
