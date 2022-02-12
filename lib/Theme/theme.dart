import 'package:flutter/material.dart';

import '../theme/colors/light_colors.dart';

class AppTheme {
  static const TextStyle buttonRegisterTextStyle = TextStyle(
      fontFamily: "Poppins", fontSize: 18, color: LightColors.kLightWhite);

  static const textFieldContainerPadding =
      EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5);

  static const pagePadding = EdgeInsets.all(30.0);
}
