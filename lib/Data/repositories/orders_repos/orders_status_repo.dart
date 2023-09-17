import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/myApplication.dart';
import '../../../app/global.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/orders_models/orders_status_model.dart';

class OrdersStatusRepo {
  Future<OrdersStatusModel?> getStatus() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/coredata/status/list'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'lang': "ar",
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint("order status whole data  is ${responseMap.toString()}");
        final sliders = ordersStatusModelFromJson(responseMap);
        return sliders;
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
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
