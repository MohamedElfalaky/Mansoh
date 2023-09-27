import 'package:flutter/material.dart';
import 'package:nasooh/app/constants.dart';

import '../../app/Style/Icons.dart';
import '../../app/Style/sizes.dart';

class Alert {
  static Future<void> alert(
      {BuildContext? context,
      String? titleAction,
      String? content,
      void Function()? action}) async {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 341,
            height: 350,
            // Adjust the height as needed, // Adjust the width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
            ),
            child: AlertDialog(
              title: Image.asset(
                dialogIcon,
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
              content: Column(
                children: [
                  Text(
                    content!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 10), // Add 10 pixels spacing
                  TextButton(
                    onPressed: action,
                    child: Text(
                      titleAction!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                          color: Constants.primaryAppColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
