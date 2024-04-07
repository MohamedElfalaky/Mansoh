import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../app/style/sizes.dart';

class CanNotSpeak extends StatelessWidget {
  const CanNotSpeak({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: width(context),
      color: Constants.primaryAppColor.withOpacity(0.1),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            "لا يمكنك التحدث مع هذا الناصح الان",
            style: TextStyle(fontSize: 12, fontFamily: Constants.mainFont),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "العودة الي طلباتي",
              style: TextStyle(
                  color: Constants.primaryAppColor,
                  fontFamily: Constants.mainFont),
            ),
          )
        ],
      ),
    );
  }
}
