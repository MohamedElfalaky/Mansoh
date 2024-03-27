import 'package:flutter/material.dart';

import '../../Presentation/widgets/shared.dart';
import '../constants.dart';

ThemeData themeData = ThemeData(
  splashColor: Colors.transparent,
    shadowColor: Colors.transparent,
    highlightColor: Colors.transparent,

    inputDecorationTheme: InputDecorationTheme(

      border: buildOutlineInputBorder(),

      enabledBorder: buildOutlineInputBorder(),
      disabledBorder: buildOutlineInputBorder(),
      focusedBorder: buildOutlineInputBorder(),
    ),
    dividerColor: Colors.transparent,
    fontFamily: 'Cairo',

    dividerTheme: const DividerThemeData(color: Colors.transparent),
    primaryColor: const Color(0xFF0085A5),
    appBarTheme: const AppBarTheme().copyWith(
      toolbarHeight: 70,
      titleSpacing: 4,
      color: Constants.whiteAppColor,
      elevation: 0,
      titleTextStyle: Constants.mainTitleFont,
    ),
    scaffoldBackgroundColor: Constants.whiteAppColor, colorScheme: ColorScheme.fromSwatch(
            primarySwatch: getMaterialColor(colorHex: 0xFF0085A5))
        .copyWith(background: Colors.white).copyWith(background: Colors.white));

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Constants.primaryAppColor, width: 1.8),
    borderRadius: BorderRadius.circular(10),
  );
}
