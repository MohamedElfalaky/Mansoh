// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:nasooh/app/global.dart';
// import 'package:nasooh/app/keys.dart';
//
// import '../../../app/utils/my_application.dart';
// import '../../../app/utils/shared_preference.dart';
// import '../models/advice_screen_models/show_advice_model.dart';
//
// class SendAdvise {
//   Future<ShowAdviceModel?> sendAdvise({
//     String? name,
//     String? description,
//     String? price,
//     String? documentsFile,
//     String? type,
//     dynamic adviserId,
//   }) async {
//     try {
//       Map<String, dynamic> map = {
//         'name': name,
//         'description': '$description',
//         'adviser_id': '$adviserId',
//         'price': '$price',
//         if (documentsFile != null) 'document[0][file]': documentsFile,
//         if (documentsFile != null) 'document[0][type]': type
//       };
//       http.Response response =
//           await http.post(Uri.parse('${Keys.baseUrl}/client/advice/store'),
//               headers: {
//                 'Accept': 'application/json',
//                 'lang': selectedLang,
//                 "Authorization": "Bearer ${sharedPrefs.getToken()}"
//               },
//               body: map);
//       if (kDebugMode) {
//         print("map advice Sent You API");
//         print(map);
//       }
//       Map<String, dynamic> responseMap = json.decode(response.body);
//       if (response.statusCode == 200 && responseMap["status"] == 1) {
//         // print(response.body);
//         final userdata = showAdviceModelFromJson(responseMap);
//         return userdata;
//       } else {
//         MyApplication.showToastView(
//             message: responseMap["message"].values.toString());
//       }
//     } on TimeoutException catch (e) {
//       MyApplication.showToastView(message: e.toString());
//       if (kDebugMode) {
//         print(e);
//       }
//     } on SocketException catch (e) {
//       MyApplication.showToastView(message: e.toString());
//       if (kDebugMode) {
//         print(e);
//       }
//     } on Error catch (e) {
//       if (kDebugMode) {
//         print(e);
//         MyApplication.showToastView(message: e.toString());
//       }
//     }
//     return null;
//   }
// }
//

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../app/utils/my_application.dart';
import '../../app/utils/dio.dart';
import '../models/advice_screen_models/show_advice_model.dart';

class SendAdvise {
  Future<ShowAdviceModel?> sendAdvise({
    String? type,
    File? file,
    String? name,
    String? description,
    String? price,
    dynamic adviserId,
  }) async {
    String fileName = file?.path.split('/').last ?? "";
    FormData formData = FormData.fromMap({
      if (file != null)
        "chat_document[0][file]": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      'name': name,
      'description': '$description',
      'adviser_id': '$adviserId',
      'price': '$price',
      if (type != null || file != null) 'chat_document[0][type]': type,
    });

    log(
        {
          if (file != null)
            "chat_document[0][file]": await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          'name': name,
          'description': '$description',
          'adviser_id': '$adviserId',
          'price': '$price',
          if (type != null || file != null) 'chat_document[0][type]': type,
        }.toString(),
        name: "Confirming");

    try {
      Dio.Response response = await dio().post(
        '/client/advice/store',
        data: formData,
      );
      // Map<String, dynamic> responseMap = json.decode(response.data);
      if (response.statusCode == 200 && response.data["status"] == 1) {
        // print(response.body);
        final userdata = showAdviceModelFromJson(response.data);
        return userdata;
      } else {
        MyApplication.showToastView(
            message: response.data["message"].values.toString());
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
