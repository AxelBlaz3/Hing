import 'package:flutter/material.dart';
import 'package:hing/theme/colors.dart';
import 'package:hing/theme/typography.dart';

class HingTheme {
  static ThemeData getHingThemeData(ThemeData baseThemeData) {
    return baseThemeData.copyWith(
      colorScheme: baseThemeData.colorScheme.copyWith(onSurface: kOnSurfaceColor, primary: kPrimaryColor),
      textTheme: kHingTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        textStyle: kHingTextTheme.button,
      )),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
        primary: kPrimaryColor,
        textStyle: kHingTextTheme.button
      )),
      tabBarTheme: baseThemeData.tabBarTheme.copyWith(
        labelColor: kOnSurfaceColor,
        labelStyle: kHingTextTheme.overline?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: kHingTextTheme.overline?.copyWith(fontWeight: FontWeight.w600)
      ),
      cardTheme: baseThemeData.cardTheme.copyWith(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),), elevation: 0)
    );
  }
}
