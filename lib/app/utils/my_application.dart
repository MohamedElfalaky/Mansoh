// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class MyApplication {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static double hightClc(BuildContext context, int myHeight) {
    return MediaQuery.of(context).size.height * myHeight / 812;
  }

  static Future<bool> checkConnection() async {
    var connectivityResult;

    connectivityResult = await (Connectivity().checkConnectivity());

    {
      return connectivityResult == ConnectivityResult.none ? false : true;
    }
  }

  static void navigateToReplace(BuildContext context, Widget page) async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static void navigateTo(BuildContext context, Widget page) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static void navigateToReplaceAllPrevious(
      BuildContext context, Widget page) async {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  static showToastView({
    required String message,
  }) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Constants.primaryAppColor,
        textColor: Constants.whiteAppColor,
        fontSize: 16.0);
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
