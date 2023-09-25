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
            height: 310, // Adjust the height as needed
            width: 310, // Adjust the width as needed
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
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
              content: Column(
                children: [
                  Text(
                    content!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10), // Add 10 pixels spacing
                  TextButton(
                    onPressed: action,
                    child: Text(
                      titleAction!,
                      style: const TextStyle(
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
