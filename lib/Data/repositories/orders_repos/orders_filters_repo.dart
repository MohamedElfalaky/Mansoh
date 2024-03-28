import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../../models/orders_models/orders_filter_model.dart';

class OrdersFiltersRepo {
  Future<OrdersFiltersModel?> getStatus({required String id}) async {
    log(sharedPrefs.getToken());
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/advice/list?status_id=$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'lang': "ar",
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        log("ALL ORDERS DATA ${response.body.length} ");
        final sliders = ordersFiltersModelFromJson(responseMap);
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
