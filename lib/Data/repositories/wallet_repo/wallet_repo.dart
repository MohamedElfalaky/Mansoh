import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nasooh/Data/models/coupons_model.dart';

import '../../../../app/keys.dart';
import '../../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';
import '../../models/wallet_models/wallet_model.dart';

class WalletRepo {
  Future<CouponsModel?> getPromoCodes() async {
    http.Response response = await http.get(
      Uri.parse('${Keys.baseUrl}/client/promo-code'),
      headers: {
        'Accept': 'application/json',
        'lang': Get.locale?.languageCode ?? "ar",
        'Authorization': 'Bearer ${sharedPrefs.getToken()}',
      },
    );
    Map<String, dynamic> responseMap = json.decode(response.body);
    if (response.statusCode == 200 && responseMap["status"] == 1) {
      return CouponsModel.fromJson(responseMap);
    } else {
      MyApplication.showToastView(message: responseMap["message"]);
    }

    return null;
  }

  Future<WalletData?> applyPromoCode({required String promoCode}) async {
    http.Response response = await http.post(
      body: {'code': promoCode},
      Uri.parse('${Keys.baseUrl}/client/promo-code/apply'),
      headers: {
        'Accept': 'application/json',
        'lang': Get.locale?.languageCode ?? "ar",
        'Authorization': 'Bearer ${sharedPrefs.getToken()}',
      },
    );

    Map<String, dynamic> responseMap = json.decode(response.body);
    debugPrint('wallet data');

    if (response.statusCode == 200) {
      if (responseMap["status"] == 0) {
        MyApplication.showToastView(message: responseMap["message"]);
      }
      return walletModelFromJson(responseMap).data;
    }


    return null;
  }

  Future<WalletData?> getData() async {
    try {
      http.Response response = await http
          .get(Uri.parse('${Keys.baseUrl}/client/wallet/show'), headers: {
        'Accept': 'application/json',
        'lang': Get.locale?.languageCode ?? "ar",
        'Authorization': 'Bearer ${sharedPrefs.getToken()}',
      });
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        return walletModelFromJson(responseMap).data;
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
