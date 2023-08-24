import 'package:flutter/cupertino.dart';

import 'lang/language_constants.dart';


class Validations {
  static String? validateName(String? name, BuildContext context) {
    String? validateString = '';
   // Pattern pattern = r'[a-zA-Zء-يa-zA-Zء-ي]';
    Pattern pattern = r'[a-zA-zء-ي]{2,}[\s]{1,}[a-zA-Zء-ي]{2,}$';
    RegExp regex = RegExp(pattern.toString());
    if (name!.trim().isEmpty) {
      validateString = "${getTranslated(context, 'pleaseentername')}";
    } else if (!regex.hasMatch(name.trim()) && name.trim().length <= 15) {
      validateString = "${getTranslated(context, 'invaliddata')}";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateNameForUpdateScreen(String? name, BuildContext context) {
    String? validateString = '';
    // Pattern pattern = r'[a-zA-Zء-يa-zA-Zء-ي]';
    Pattern pattern = r'[a-zA-zء-ي]{2,}[\s]{1,}[a-zA-Zء-ي]{2,}$';
    RegExp regex = RegExp(pattern.toString());
    if (name!.trim().isEmpty) {
      validateString = null;
    } else if (!regex.hasMatch(name.trim()) && name.trim().length <= 15) {
      validateString = "${getTranslated(context, 'invaliddata')}";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateMail(String? email, BuildContext context) {
    String? validateString = '';
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    if (email == null || email.trim().isEmpty) {
      validateString = null;
    } else if (!regex.hasMatch(email.trim())) {
      validateString = "${getTranslated(context, 'invaliddata')}";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validatePhone(String phone, BuildContext context) {
    String? validateString = '';

    if (phone.trim().isEmpty) {
      validateString = "${getTranslated(context, 'emptyfield')}";
    } else if (phone.trim().length != 9) {
      validateString = "${getTranslated(context, 'invaliddata')}";
    } else if (!phone.startsWith("5", 0)) {
      validateString = getTranslated(context, "invaliddata");
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validatePassword(String password, BuildContext context) {
    String? validateString = '';

    if (password.trim().isEmpty) {
      validateString = "${getTranslated(context, 'emptyfield')}";
    }
    // else if (password.length < 6) {
    //   validateString = "invalid password";
    // }
    else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateconPassword(
      String password, BuildContext context, String conpass) {
    String? validateString = '';

    if (conpass.trim().isEmpty) {
      validateString = "${getTranslated(context, 'emptyfield')}";
    } else if (password.toString() != conpass.toString()) {
      validateString = "${getTranslated(context, 'DifferentPasswords')}";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateField(String value, BuildContext context) {
    String? validateString = '';
    if (value.trim().isEmpty) {
      validateString = "${getTranslated(context, 'emptyfield')}";
    } else {
      validateString = null;
    }
    return validateString;
  }

  static   String validationEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}
