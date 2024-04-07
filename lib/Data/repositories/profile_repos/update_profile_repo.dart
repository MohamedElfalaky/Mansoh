import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/app/keys.dart';

import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/profile_models/update_profile_model.dart';

class UpdateProfile {
  Future<UpdateProfileModel?> update(
      {String? email,
      String? fullName,
      String? mobile,
      String? countryId,
      String? cityId,
      String? cityName,
      String? nationalityName,
      String? countryName,
      String? gender,
      String? nationalityId,
      String? avatar}) async {
    http.Response response =
        await http.post(Uri.parse('${Keys.baseUrl}/client/update'), headers: {
      'Accept': 'application/json',
      'lang': Get.locale?.languageCode ?? "ar",
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
    if (response.statusCode == 200 && responseMap["status"] == 1) {
      final userData = updateProfileModelFromJson(responseMap);
      sharedPrefs.setId(userData.data!.id!);
      sharedPrefs.setUserName(userData.data!.fullName!);
      sharedPrefs.setUserNationality(nationalityName ?? '');
      sharedPrefs.setUserCountry(countryName ?? '');
      sharedPrefs.setUserCity(cityName ?? '');
      sharedPrefs.setUserType(userData.data?.gender ?? '');
      sharedPrefs.setUserPhoto(userData.data?.avatar ?? '');

      MyApplication.showToastView(message: responseMap["message"]);
      return userData;
    } else {
      MyApplication.showToastView(
          message: responseMap["message"].values.toString());
    }

    return null;
  }
}
