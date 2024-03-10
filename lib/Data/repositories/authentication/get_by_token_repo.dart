import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import 'package:http/http.dart' as http;

import '../../models/Auth_models/get_by_token_model.dart';

class GetByTokenRepo {
  Future<GetByTokenModel?> getGetByToken() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/auth/get_user'),
        headers: {
          'Accept': 'application/json',
          'lang': Get.locale?.languageCode ?? "ar",
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print("get profile data ${response.body}" );
        final userdata = getByTokenModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        return userdata;
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
