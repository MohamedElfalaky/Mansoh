import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../../app/utils/my_application.dart';
import '../../../app/global.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/advice_screen_models/show_advice_model.dart';

class DoneAdviceRepo {
  Future<ShowAdviceModel?> doneAdvice({required int adviceId}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${Keys.baseUrl}/client/advice/done/$adviceId'),
        headers: {
          'Accept': 'application/json',
          'lang': selectedLang,
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      // print(responseMap);
      // print(response.statusCode);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint("the response of pay  is ${responseMap.toString()}");
        final adviceShowResult = showAdviceModelFromJson(responseMap);
        return adviceShowResult;
      } else {
        MyApplication.showToastView(message: responseMap["message"]);
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
