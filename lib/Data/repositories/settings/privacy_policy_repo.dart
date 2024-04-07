import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/settings_models/privacy_policy_model.dart';

class PolicyRepo {
  Future<PrivacyPolicyModel?> getPolicy() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/setting/page/policy'),
        headers: {
          'Accept': 'application/json',
          // 'lang': selectedLang!,
          'lang': "ar",
          "Authorization": "Bearer ${sharedPrefs.getToken()}"
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print(response.body);
        final homeStatusData = privacyPolicyModelFromJson(responseMap);
        return homeStatusData;
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
