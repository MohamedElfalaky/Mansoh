import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/myApplication.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../models/home_models/advisor_list_model.dart';

class AdvisorListRepo {
  Future<AdvisorListModel?> getAdList(
      {String? catVal, String ?searchTxt, double? rateVal}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/adviser/list?category=$catVal&name=$searchTxt&rate=$rateVal'),
        headers: {
          'Accept': 'application/json',
          'lang': Get.locale?.languageCode ??"ar",
          'Authorization': 'Bearer ${sharedPrefs.getToken()}',
        },
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint(responseMap.toString());
        final categoryFields = advisorListModelFromJson(responseMap);
        debugPrint("Data from Api is ${categoryFields.data!}");
        return categoryFields;
      } else {
        // debugPrint("request is $phone & $pass");
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
    } on Error catch (e ,st) {
      if (kDebugMode) {
        print(e);
        print(st);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}
