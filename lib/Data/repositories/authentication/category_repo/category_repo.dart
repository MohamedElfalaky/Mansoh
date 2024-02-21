import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/Data/models/Auth_models/category_model.dart';
import '../../../../app/keys.dart';
import '../../../../app/utils/my_application.dart';

class CategoryRepo {
  Future<CategoryModel?> getData() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Keys.baseUrl}/client/coredata/category/list'),
        // headers: GlobalVars().headers,
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {

        final categoryFields = CategoryModel.fromJson(responseMap);

        // MyApplication.showToastView(message: responseMap["message"]);
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
    } on Error catch (e) {
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}


