/// vars with changeable values
class GlobalVars {
  Map<String, String>? headers = {
    'Accept': 'application/json',
    'lang': selectedLang!
  };
  String? oldLang;

  String? androidRelease;
}

String? selectedLang;
