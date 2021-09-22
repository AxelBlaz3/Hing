import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hing/theme/colors.dart';
import 'package:hing/theme/typography.dart';

class HingTheme {
  static ThemeData getHingThemeData(ThemeData baseThemeData) {
    return baseThemeData.copyWith(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        primaryTextTheme: baseThemeData.primaryTextTheme.copyWith(
            headline6:
                kHingTextTheme.headline6?.copyWith(color: kOnSurfaceColor)),
        appBarTheme: baseThemeData.appBarTheme.copyWith(
            backgroundColor: kScaffoldBackgroundColor,
            elevation: 0,
            centerTitle: false,
            titleTextStyle: GoogleFonts.abrilFatface()),
        colorScheme: baseThemeData.colorScheme.copyWith(
            onSurface: kOnSurfaceColor,
            primary: kPrimaryColor,
            secondary: kOnSurfaceColor),
        textTheme: kHingTextTheme.apply(
          bodyColor: kOnSurfaceColor,
          displayColor: kOnSurfaceColor,
        ),
        inputDecorationTheme: baseThemeData.inputDecorationTheme.copyWith(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none)),
        iconTheme: baseThemeData.iconTheme.copyWith(color: kOnSurfaceColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: kOnSurfaceColor,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          textStyle: kHingTextTheme.button,
        )),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: kOnSurfaceColor, textStyle: kHingTextTheme.button)),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                primary: kPrimaryColor,
                textStyle: kHingTextTheme.button)),
        checkboxTheme: baseThemeData.checkboxTheme
            .copyWith(fillColor: MaterialStateProperty.all(kPrimaryColor)),
        tabBarTheme: baseThemeData.tabBarTheme.copyWith(
            labelColor: kOnSurfaceColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            indicator: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(24),
            ),
            labelStyle:
                kHingTextTheme.caption?.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle:
                kHingTextTheme.caption?.copyWith(fontWeight: FontWeight.w600)),
        cardTheme: baseThemeData.cardTheme.copyWith(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0));
  }
}
