import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import '../../models/rejection_models/post_reject_model.dart';

class PostRejectRepo {
  Future<PostRejectModel?> reject({
    String? commentId,
    String? commentOther,
    String? adviceId,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${Keys.baseUrl}/client/advice/reject/$adviceId'),
          headers: {
            'Accept': 'application/json',
            'lang': Get.locale?.languageCode ?? "ar",
            "Authorization": "Bearer ${sharedPrefs.getToken()}"
          },
          body: {
            'comment_id': commentId,
            'comment_other': '$commentOther',
          });
      Map<String, dynamic> responseMap = json.decode(response.body);

      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print("response.bodyis ${response.body}");
        final userdata = postRejectModelFromJson(responseMap);
        // sharedPrefs.setToken(userdata.data!.token!);
        // MyApplication.showToastView(message: responseMap["message"]);
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
