import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/Auth_models/log_out_model.dart';
import 'package:http/http.dart' as http;

class LogOutRepo {
  Future<LogOutModel?> logOut() async {
    try {
      http.Response response = await http
          .post(Uri.parse('${Keys.baseUrl}/client/auth/logout'), headers: {
        'Accept': 'application/json',
        'lang': "ar",
        'Authorization': 'Bearer ${sharedPrefs.getToken()}',
      }, body: {
        'device': sharedPrefs.fCMToken,
      });
      debugPrint("the token is ${sharedPrefs.getToken()}");
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint("the response  is ${response.body}");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final userdata = logOutModelFromJson(responseMap);
        await preferences.clear();
        sharedPrefs.removeToken();
        sharedPrefs.removeFCM();

        // MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        // debugPrint("request is $phone & $pass");
        MyApplication.showToastView(message: responseMap["message"].toString());
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
