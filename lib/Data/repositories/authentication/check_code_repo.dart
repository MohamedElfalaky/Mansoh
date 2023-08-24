import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../models/Auth_models/check_code_model.dart';
import '../../models/Auth_models/check_mobile_model.dart';
import 'package:http/http.dart' as http;

class CheckCodeRepo {
  Future<CheckCodeModel?> checkCode({String? mobile, String? code}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/client/check_mobile/code'),
          headers: GlobalVars().headers,
          body: {
            'mobile': '$mobile',
            'code': '$code',
          });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        final userdata = checkCodeModelFromJson(responseMap);
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
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
