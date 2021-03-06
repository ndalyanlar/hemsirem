import 'package:flutter/material.dart';

import '../Theme/colors/light_colors.dart';

class AppTheme {
  static const TextStyle buttonRegisterTextStyle = TextStyle(
      fontFamily: "Poppins", fontSize: 18, color: LightColors.kLightWhite);

  // ignore: non_constant_identifier_names
  static TextStyle LoginPageButtonsTextStyle = TextStyle(
      color: Colors.red.shade300, fontSize: 22, fontFamily: "Poppins");

  static const textFieldContainerPadding =
      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5);

  static const pagePadding = EdgeInsets.all(30.0);

  static var appBarTheme = AppBarTheme(
    color: LightColors.kLightRed4,
    centerTitle: true,
  );

  static double loginPageborderRadius = 30;

  static ButtonStyle loginPageButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppTheme.loginPageborderRadius),
              side: const BorderSide(color: Colors.red))),
      backgroundColor: MaterialStateProperty.all(Colors.white70),
      fixedSize: MaterialStateProperty.all(const Size.fromWidth(200)));

  static TextStyle homePageTextStyle =
      const TextStyle(color: LightColors.kDarkBlue, fontFamily: 'Poppins');
}
