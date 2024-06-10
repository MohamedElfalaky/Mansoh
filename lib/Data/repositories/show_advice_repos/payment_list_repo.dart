import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../../app/utils/my_application.dart';
import '../../../app/global.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/advice_screen_models/payment_list_model.dart';

class PaymentListRepo {
  Future<PaymentListModel?> getPay() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/coredata/payment/list'),
        headers: {
          'Accept': 'application/json',
          'lang': selectedLang,
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint(responseMap.toString());
        final categoryFields = paymentListModelFromJson(responseMap);
        debugPrint("Data from Api is ${categoryFields.data![0].id}");

        // MyApplication.showToastView(message: responseMap["message"]);
        return categoryFields;
      } else {
        // debugPrint("request is $phone & $pass");
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
