import 'package:flutter/material.dart';
import 'package:nasooh/app/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final dynamic onPressedHandler;
  final String? txt;
  final Color? btnColor;
  final Color? txtColor;
  final double? txtSize;
  final bool? isBold;
  final Widget? prefixWidget;
  const CustomElevatedButton(
      {super.key,
      this.onPressedHandler,
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        textStyle: const TextStyle(fontWeight: FontWeight.normal),
        elevation: 0,
        backgroundColor: btnColor ?? Constants.primaryAppColor,
      ),
      onPressed: onPressedHandler ?? () {},
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? const SizedBox(),
            Container(
              margin: const EdgeInsets.all(3),
              child: Text(
                txt ?? "button",
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

class CustomLoadingButton extends StatelessWidget {
  final dynamic onPressedHandler;

  final bool? isBold;
  final Widget? prefixWidget;
  const CustomLoadingButton(
      {super.key, this.onPressedHandler, this.isBold, this.prefixWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          textStyle: const TextStyle(fontWeight: FontWeight.normal),
          elevation: 0,
          backgroundColor: Constants.primaryAppColor,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Center(
            child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white),
          ),
        ),
      ),
    );
  }
}

class MyButtonOutlined extends StatelessWidget {
  final void Function()? onPressedHandler;
  final String? txt;
  final Color? btnColor;
  final Color? txtColor;
  final double? txtSize;
  final bool? isBold;
  final Widget? prefixWidget;
  const MyButtonOutlined(
      {super.key,
      this.onPressedHandler,
      this.txt,
      this.btnColor,
      this.txtColor,
      this.txtSize,
      this.isBold,
      this.prefixWidget});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.normal),
          side: const BorderSide(color: Constants.primaryAppColor)),
      onPressed: onPressedHandler,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? const SizedBox(),
            Container(
              margin: const EdgeInsets.all(3),
              child: Text(
                '$txt',
                style: TextStyle(
                    fontWeight:
                        isBold == true ? FontWeight.bold : FontWeight.normal,
                    fontFamily: Constants.mainFont,
                    fontSize: txtSize ?? 14,
                    color: txtColor ?? Constants.primaryAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
