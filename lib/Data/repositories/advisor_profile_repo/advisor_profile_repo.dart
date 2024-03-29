import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../models/advisor_profile_model/advisor_profile.dart';

class AdvisorProfileRepo {
  Future<AdvisorProfileModel?> getProfile(int id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/adviser/profile/$id'),
        headers: headers,
      );
      debugPrint(response.body);
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        // print("get profile data ${response.body}" );
        final userdata = advisorProfileModelFromJson(responseMap);
        log("get Orders data ${response.body}" );

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
