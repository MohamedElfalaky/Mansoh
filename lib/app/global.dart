/// vars with changeable values
class GlobalVars {
  Map<String, String>? headers = {
    'Accept': 'application/json',
    'lang': selectedLang??"ar"
    // 'lang': "ar"
  };
  String? oldLang;

  String? androidRelease;
}

String? selectedLang;
