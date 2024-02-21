import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/my_application.dart';
import '../../../app/global.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../../models/advice_screen_models/show_advice_model.dart';

class ShowAdviceRepo {
  Future<ShowAdviceModel?> getAdvice({required int adviceId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/advice/show/$adviceId'),
        headers: {
          'Accept': 'application/json',
          'lang': selectedLang,
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint("responseMap.toString() is ${responseMap.toString()}");
        final adviceShowResult = showAdviceModelFromJson(responseMap);
        return adviceShowResult;
      }
    } on TimeoutException catch (e) {
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on SocketException catch (e) {
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on Error catch (e, st) {
      if (kDebugMode) {
        print(e);
        print(st);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
