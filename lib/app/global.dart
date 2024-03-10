import 'package:get/get.dart';

/// vars with changeable values

Map<String, String>? headers = {
  'Accept': 'application/json',
  'lang': selectedLang
  // 'lang': "ar"
};
// String? oldLang;

String? androidRelease;

String selectedLang = Get.locale?.languageCode ?? "ar";
