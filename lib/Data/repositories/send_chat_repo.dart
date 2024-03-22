import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:nasooh/app/global.dart';
import 'package:nasooh/app/keys.dart';
import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference_class.dart';
import 'package:http/http.dart' as http;

class SendChatRepo {
  Future<bool?> sendChat({
    String? msg,
    String? adviceId,
    String? file,
    String? type,
  }) async {
    try {
      Map<String, dynamic> map = {
        'message': msg,
        'advice_id': '$adviceId',
        if (file != null) 'document[0][type]': type,
        if (file != null) 'document[0][file]': file,
      };

      http.Response response =
          await http.post(Uri.parse('${Keys.baseUrl}/client/chat/store'),
              headers: {
                'Accept': 'application/json',
                'lang': selectedLang,
                "Authorization": "Bearer ${sharedPrefs.getToken()}"
              },
              body: map);

       debugPrint('send chat repo ${response.body}');
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200 && responseMap["status"] == 1) {
        debugPrint(response.body.toString());
        return true;
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
