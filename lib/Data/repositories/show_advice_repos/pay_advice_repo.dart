import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/myApplication.dart';
import '../../../app/global.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/advice_screen_models/show_advice_model.dart';

class PayAdviceRepo {
  Future<ShowAdviceModel?> payAdvice(
      {required int adviceId, required int paymentId}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${Keys.baseUrl}/client/advice/pay/$adviceId'),
        body: {
          'payment_id': '$paymentId',
        },
        headers: {
          'Accept': 'application/json',
          'lang': selectedLang,
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
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
    } on Error catch (e,st) {
      if (kDebugMode) {
        print(e);
        print(st);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
