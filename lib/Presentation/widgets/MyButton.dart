import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/constants.dart';

class MyButton extends StatelessWidget {
  final onPressedHandler;
  final String? txt;
  final Color? btnColor;
  final Color? txtColor;
  final double? txtSize;
  final bool? isBold;
  final Widget? prefixWidget;
  const MyButton(
      {this.onPressedHandler,
      this.txt,
      this.btnColor,
      this.txtColor,
      this.txtSize,
      this.isBold,
      this.prefixWidget});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        textStyle: TextStyle(fontWeight: FontWeight.normal),
        elevation: 0,
        backgroundColor: btnColor ?? Constants.primaryAppColor,
      ),
      onPressed: onPressedHandler,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? SizedBox(),
            Container(
              margin: EdgeInsets.all(3),
              child: Text(
                '$txt',
                style: TextStyle(
                    fontWeight:
                        isBold == true ? FontWeight.bold : FontWeight.normal,
                    fontFamily: Constants.mainFont,
                    fontSize: txtSize ?? 14,
                    color: txtColor ?? Constants.whiteAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
