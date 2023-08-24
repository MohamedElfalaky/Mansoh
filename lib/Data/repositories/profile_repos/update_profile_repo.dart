import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import 'package:http/http.dart' as http;

import '../../models/profile_models/update_profile_model.dart';

class UpdateProfile {
  Future<UpdateProfileModel?> update({String? email,
    String? fullName,
    String? mobile,
    String? countryId,
    String? cityId,
    String? gender,
    String? nationalityId,
    String? avatar}) async {
    try {
      http.Response response =
      await http.post(Uri.parse('${Keys.baseUrl}/client/update'), headers: {
        'Accept': 'application/json',
        'lang': selectedLang!,
        "Authorization": "Bearer ${sharedPrefs.getToken()}"
      }, body: {
        'email': email,
        'full_name': '$fullName',
        'mobile': '$mobile',
        'country_id': '$countryId',
        'city_id': '$cityId',
        'gender': '$gender',
        'nationality_id': '$nationalityId',
        'avatar[0][type]': 'png',
        'avatar[0][file]': '$avatar',
      });
      Map<String, dynamic> responseMap = json.decode(response.body);

      print(
          "'email': email  ,'full_name': '$fullName','mobile': '$mobile','country_id': '$countryId','city_id': '$cityId','gender': '$gender','nationality_id': '$nationalityId','avatar[0][type]': 'png','avatar[0][file]': '$avatar',");
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        print(response.body);
        final userdata = updateProfileModelFromJson(responseMap);
        // sharedPrefs.setToken(userdata.data!.token!);
        sharedPrefs.setId(userdata.data!.id!);
        sharedPrefs.setUserName(userdata.data!.fullName!);
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
