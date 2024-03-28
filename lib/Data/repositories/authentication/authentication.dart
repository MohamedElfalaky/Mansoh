import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../../models/Auth_models/login_model.dart';

class Auth {
  ///Create Login Cycle
  Future<LoginModel?> login({String? phone, String? pass}) async {
    try {
      var response = await http
          .post(Uri.parse('${Keys.baseUrl}/login'), headers: headers, body: {
        'phone': '$phone',
        'password': '$pass',
        'device': sharedPrefs.fCMToken,
      });
      Map<String, dynamic> responsemap = json.decode(response.body);
      if (response.statusCode == 200 && responsemap["success"] == true) {
        // final userdata = LoginModel.fromJson(jsonDecode(response.body));
        // sharedPrefs.setToken(userdata.data.token);
        // sharedPrefs.setUserName(userdata.data.name);
        // if (userdata.data.hasMedia) {
        //   sharedPrefs.setUserPhoto(userdata.data.media[0].thumb);
        // } else {
        //   sharedPrefs.setUserPhoto('');
        // }
        // MyApplication.showToastView(message: responsemap["message"]);
        // return userdata;
      } else {
        MyApplication.showToastView(message: responsemap["message"]);
      }
    } on TimeoutException catch (e) {
      // todo show toast
      if (kDebugMode) {
        print(e);
      }
    } on SocketException catch (e) {
      // todo show toast
      if (kDebugMode) {
        print(e);
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
