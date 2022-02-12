import 'package:flutter/material.dart';

import '../Theme/colors/light_colors.dart';

class AppTheme {
  static const TextStyle buttonRegisterTextStyle = TextStyle(
      fontFamily: "Poppins", fontSize: 18, color: LightColors.kLightWhite);

  static TextStyle LoginPageButtonsTextStyle = TextStyle(
      color: Colors.red.shade300, fontSize: 22, fontFamily: "Poppins");

  static const textFieldContainerPadding =
      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5);

  static const pagePadding = EdgeInsets.all(30.0);

  static var appBarTheme = AppBarTheme(
    color: LightColors.kLightRed4,
    centerTitle: true,
  );

  static ButtonStyle loginPageButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white70),
      fixedSize: MaterialStateProperty.all(Size.fromWidth(200)));
}
