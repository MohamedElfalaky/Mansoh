import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../../models/Auth_models/register_model.dart';

class GetUserByMobile {
  Future<RegisterModel?> getUser({
    String? mobile,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/client/auth/getUserByMobile'),
          headers: headers,
          body: {
            'mobile': '$mobile',
            'device': sharedPrefs.fCMToken,
          });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print(response.body);
        final userdata = registerModelFromJson(responseMap);
        sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setId(userdata.data!.id!);
        sharedPrefs.setUserName(userdata.data!.fullName!);
        sharedPrefs.setIsNotification(userdata.data!.isNotification ?? 0);
        if (userdata.data!.avatar != "") {
          sharedPrefs.setUserPhoto(userdata.data!.avatar!);
        } else {
          sharedPrefs.setUserPhoto('');
        }
        MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        MyApplication.showToastView(
            message: responseMap["message"].values.toString());
        // message: responseMap["message"].toString());
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
