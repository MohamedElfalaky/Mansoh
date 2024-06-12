import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/utils/shared_preference.dart';

Dio dio() {
  Dio dio = Dio();
  dio.options.baseUrl = "https://uat.nasoh.app/Admin";
  dio.options.connectTimeout = Duration(seconds: 20000);
  dio.options.headers.addAll({
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'lang': Get.locale?.languageCode ?? "ar",
    "Authorization": "Bearer ${sharedPrefs.getToken()}"
  });

  dio.options.validateStatus = (status) {
    return status! < 500;
  };
  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      error: true,
      requestBody: true,
      requestHeader: true,
    ),
  );
  return dio;
}
