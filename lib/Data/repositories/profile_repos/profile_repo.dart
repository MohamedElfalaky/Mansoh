import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/models/profile_models/profile_model.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import 'package:http/http.dart' as http;

class GetProfileRepo {
  Future<ProfileModel?> getProfile() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/profile/${sharedPrefs.getId()}'),
        headers: {
          'Accept': 'application/json',
          'lang':  Get.locale?.languageCode ??"ar",
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print("get profile data ${response.body}" );
        final userdata = profileModelFromJson(responseMap);
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
