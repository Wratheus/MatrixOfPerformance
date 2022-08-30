import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: MyColors.mainInnerColor,
        secondary: MyColors.mainBeige,
        background: MyColors.mainCanvas,
        onBackground: MyColors.mainCanvas
      ),
  );
}