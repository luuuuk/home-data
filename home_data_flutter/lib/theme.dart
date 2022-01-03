import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColors {
  static const lightWhite = Color.fromRGBO(250, 249, 249, 1.0);
  static const lightGrey = Color.fromRGBO(244, 242, 242, 1.0);
  static const midGrey = Color.fromRGBO(225, 225, 225, 1.0);
  static const darkGrey = Color.fromRGBO(104, 104, 104, 1.0);
  static const accentYellow = Color.fromRGBO(254, 180, 99, 1.0);
}

class VisualizationTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ThemeColors.lightWhite,

    // Define the default font family.
    fontFamily: 'Montserrat',
    cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        primaryColor: ThemeColors.lightWhite,
      ),
    ),
  );
}
