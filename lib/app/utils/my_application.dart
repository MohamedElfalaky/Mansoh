
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MyApplication {
  static double hightClc(BuildContext context, int myHeight) {
    return MediaQuery.of(context).size.height * myHeight / 812;
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

  static showToastView({required String message, Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.lightBlue,
        textColor: Colors.white,
        fontSize: 16);
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
