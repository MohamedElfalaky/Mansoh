import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/my_application.dart';
import '../../../models/Auth_models/city_model.dart';

class CityRepo {
  Future<CityModel?> getCities({String? id}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/coredata/city/list?country_id=$id'),
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        final categoryFields = cityModelFromJson(responseMap);
        return categoryFields;
      } else {
        // print('get cities error ');
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
