import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  final Locale? locale;

  DemoLocalization(this.locale);

  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String>? _localizedValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${locale!.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues![key] ?? "not found";
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'ar',
    ].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => false;
}
