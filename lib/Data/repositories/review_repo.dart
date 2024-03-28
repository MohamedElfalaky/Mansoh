import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../models/rejection_models/post_reject_model.dart';

class ReviewRepo {
  Future<PostRejectModel?> review({
    String? speed,
    String? quality,
    String? flexibility,
    String? other,
    dynamic adviser,
    dynamic adviceId,
    dynamic app,
  }) async {
    Map<String, dynamic> mapData = {
      'rate_speed': '$speed',
      'rate_quality': '$quality',
      'rate_flexibility': '$flexibility',
      'rate_adviser': '$adviser',
      'rate_app': '$app',
      'rate_other': '$other'
    };
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/client/advice/review/$adviceId'),
          headers: {
            'Accept': 'application/json',
            'lang': selectedLang,
            "Authorization": "Bearer ${sharedPrefs.getToken()}"
          },
          body: mapData);
      // print(mapData);
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print(response.body);
        final userdata = postRejectModelFromJson(responseMap);
        MyApplication.showToastView(message: responseMap["message"]);
        return userdata;
      } else {
        MyApplication.showToastView(
            message: responseMap["message"].values.toString());
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
