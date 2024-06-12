import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../app/utils/my_application.dart';
import '../../app/utils/dio.dart';

class SendChatRepo {
  Future<bool?> sendChat({
    String? msg,
    String? adviceId,
    String? typee,
    File? file,
  }) async {
    String fileName = file?.path.split('/').last ?? "";
    FormData formData = FormData.fromMap({
      if (file != null)
        "chat_document[0][file]": await MultipartFile.fromFile(file.path,
          filename:  fileName,
        ),
      if (msg != "" && msg != null) 'message': msg,
      'advice_id': '$adviceId',
      if (typee  != null || file !=null)   'chat_document[0][type]': typee,
    });

    log({
      if (file != null)
        "chat_document[0][file]": await MultipartFile.fromFile(file.path,
          filename:  fileName,
        ),
      if (msg != "" && msg != null) 'message': msg,
      'advice_id': '$adviceId',
      if (typee  != null || file !=null)   'chat_document[0][type]': typee,
    }.toString() , name: "SendChatRepo");

    try {
      Dio.Response response = await dio().post(
        '/client/chat/store',
        data: formData,
      );
      if (response.statusCode == 200 && response.data["status"] == 1) {
        debugPrint(response.data.toString());
        return true;
      } else {
        MyApplication.showToastView(
            message: response.data["message"].values.toString());
      }
    } on TimeoutException catch (e, st) {
      log(st.toString(), name: "First");
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on SocketException catch (e, st) {
      log(st.toString(), name: "Second");
      MyApplication.showToastView(message: e.toString());
      if (kDebugMode) {
        print(e);
      }
    } on Error catch (e, st) {
      log(st.toString(), name: "Third");
      if (kDebugMode) {
        print(e);
        MyApplication.showToastView(message: e.toString());
      }
    }
    return null;
  }
}