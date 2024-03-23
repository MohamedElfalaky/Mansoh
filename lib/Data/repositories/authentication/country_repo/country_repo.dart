import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/keys.dart';
import 'package:http/http.dart' as http;
import '../../../../app/utils/my_application.dart';
import '../../../models/countries_and_nationalities_model.dart';

class CountryRepo {
  Future<CountriesAndNationalitiesModel?> getCountries() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/coredata/country_nationality'),
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint(responseMap.toString());
        final categoryFields =
            CountriesAndNationalitiesModel.fromJson(responseMap);

        return categoryFields;
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
