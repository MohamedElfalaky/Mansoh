import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/Auth_models/login_model.dart';

class IsNotificationRepo {
  Future<LoginModel?> isNotify() async {
    try {
      http.Response response = await http.get(
          Uri.parse('${Keys.baseUrl}/client/setting?key=is_notification'),
          headers: {
            'Accept': 'application/json',
            'lang': Get.locale?.languageCode ?? "ar",
            "Authorization": "Bearer ${sharedPrefs.getToken()}"
          });

      // debugPrint("request is $phone & $pass");
      debugPrint("response is ${response.body.toString()}");
      // debugPrint("response code is ${response.statusCode.toString()}");
      Map<String, dynamic> responseMap = json.decode(response.body);
      // debugPrint("response is ${response.toString()}");

      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final userdata = loginModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setId(userdata.data!.id!);
        sharedPrefs.setIsNotification(userdata.data!.isNotification!);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
        // MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        // debugPrint("request is $phone & $pass");
        MyApplication.showToastView(message: responseMap["message"].toString());
      }
    } on TimeoutException catch (e, st) {
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
        print(st);
      }
    } on SocketException catch (e, st) {
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
        print(st);
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
