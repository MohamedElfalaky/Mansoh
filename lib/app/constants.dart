import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// vars with fixed values
class Constants {
  /// colors
  static const Color secondAppColor = Color(0xFFFAB753);
  static const Color primaryAppColor = Color(0xFF0085A5);
  static const Color mainFontColor = Color(0xFF000816);
  static const Color fontHintColor = Color(0xFFB0B0B0);
  static const Color fontErrorColor = Color(0xFFB00020);
  static const Color fontSuccessColor = Color(0xFF00C853);
  static const Color fontWarningColor = Color(0xFFFFAB00);
  static const Color secondaryFontColor = Color(0xFF444444);
  static const Color prefixContainerColor = Color(0xFFEEEEEE);
  static const Color whiteAppColor = Color(0xFFFFFFFF);
  static const Color outLineColor = Color(0xFFBDBDBD);

  // fonts
  static const String mainFont = 'Cairo';

  static const TextStyle headerNavigationFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 18,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle mainTitleFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 16,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mainTitleRegularFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 16,
    color: mainFontColor,
  );

  static const TextStyle secondaryTitleFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 14,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle secondaryTitleRegularFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 14,
    color: mainFontColor,
  );
  static const TextStyle subtitleFont1 = TextStyle(
    fontFamily: mainFont,
    fontSize: 14,
    color: secondaryFontColor,
  );

  static const TextStyle subtitleFontBold = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: mainFontColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: mainFontColor,
  );

  static const TextStyle subtitleRegularFont = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: secondaryFontColor,
  );

  static const TextStyle subtitleRegularFontHint = TextStyle(
    fontFamily: mainFont,
    fontSize: 12,
    color: fontHintColor,
  );

   static setTextInputDecoration(
      {Widget? prefixIcon,
      Widget? suffixIcon,
      Color? prefixColor,
      EdgeInsets? contentPadding,
      Color? suffixColor,
      Color? borderColor,
      Color? hintColor,
      Color? fillColor,
      String? hintText,
      bool? isPrefexed,
      bool? isSuffix,
      bool? isFilled,
      bool? isParagraphTextField}) {
    return isParagraphTextField == true
        ? InputDecoration(
      counterText: '',
            errorStyle: const TextStyle(fontFamily: Constants.mainFont),
            labelStyle:   const TextStyle(fontFamily: Constants.mainFont),
            helperStyle: const TextStyle(fontFamily: Constants.mainFont),
            fillColor: fillColor,
            filled: true,
            suffixIcon: isSuffix == true
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: suffixIcon,
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            border: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
            disabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            hintText: hintText,
            hintStyle:   TextStyle(
              fontFamily: mainFont,
              fontSize: 12,
              color:hintColor?? const Color(0xFF5C5E6B),
            ))
        : InputDecoration(
      counterText: '',
            fillColor: fillColor,
            filled: isFilled,
            enabledBorder: outlineInputBorder(),
            disabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            prefixIcon: isPrefexed == false
                ? null
                : Padding(
                    padding: const EdgeInsets.all(4),
                    child: prefixIcon,
                  ),
            prefixIconColor: prefixColor,
            suffixIconColor: suffixColor,
            suffixIcon: isSuffix == true
                ? Padding(
                    padding: const EdgeInsets.all(3),
                    child: suffixIcon,
                  )
                : null,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            border: const OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                color: Color(0xff808488),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            hintText: hintText,
            hintStyle:   TextStyle(
              fontFamily: mainFont,
              fontSize: 12,
              color:hintColor?? fontHintColor,
            ));
  }

  static OutlineInputBorder outlineInputBorder() {
    return const OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: primaryAppColor),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }

  /// strings

  /// integers
  static final defaultPinTheme = PinTheme(
    width: 70,
    height: 70,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color(0xFF0085A5)),
    borderRadius: BorderRadius.circular(20),
  );

  static final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  static final errorPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      border: Border.all(color: Colors.red),
    ),
  );

  static InputDecoration setRegistrationTextInputDecoration(
      {Widget? prefixIcon,
      Widget? suffixIcon,
      Color? prefixColor,
      Color? suffixColor,
      Color? borderColor,
      Color? fillColor,
      bool? isParagraph,
      String? hintText}) {
    return InputDecoration(
      errorStyle: Constants.subtitleFont1.copyWith(
        color: Colors.red,
      ),
      prefixIcon: isParagraph == true
          ? SizedBox(
              height: 140,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, end: 6, top: 10, bottom: 10),
                    child: Container(
                      width: 30,
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 1, color: Color(0xFFBDBDBD)))),
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: prefixIcon,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 12, end: 6, top: 10, bottom: 10),
              child: Container(
                width: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1, color: Color(0xFFBDBDBD)))),
                margin: const EdgeInsetsDirectional.only(end: 8),
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: prefixIcon,
              ),
            ),
      prefixIconColor: prefixColor,
      suffixIconColor: suffixColor,
      suffixIcon: Padding(
        padding: const EdgeInsets.all(4),
        child: suffixIcon,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: const OutlineInputBorder(
        gapPadding: 0,
        borderSide: BorderSide(
          color: Color(0xff808488),
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      hintText: hintText,
      suffixStyle: const TextStyle(
        fontFamily: Constants.mainFont,
        fontSize: 12,
        color: fontHintColor,
      ),
      hintStyle: const TextStyle(
        fontFamily: Constants.mainFont,
        fontSize: 12,
        color: fontHintColor,
      ),
    );
  }

  static String imagePlaceHolder='https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png';
}
