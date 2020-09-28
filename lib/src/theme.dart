import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'extensions/color.dart';

class ExtTheme {
  static light({
    Color primaryColor,
  }) {
    final Color primary = primaryColor ?? Color(0xFF8F48C4);
    final Color backgroundColor = Color(0xFFFFFFFF);
    final Color unselectedColor = Colors.grey;

    return ThemeData(
        primaryColor: primary,
        accentColor: primary,
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor,
        primaryColorBrightness: Brightness.light,
        toggleableActiveColor: primary.lighten(),
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 15,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.9,
          color: backgroundColor,
          brightness: Brightness.light,
        ),
        colorScheme: ColorScheme.light(
          primary: primary,
          secondary: primary,
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          height: 50,
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.red,
          isDense: true,
          filled: true,
          fillColor: Colors.grey[100],
        ),
        tabBarTheme: TabBarTheme(
          labelColor: primary,
          unselectedLabelColor: unselectedColor,
        ),
        indicatorColor: primary,
        cursorColor: primary,
        textSelectionColor: primary.withOpacity(0.3),
        textSelectionHandleColor: primary.darken(20),
        cupertinoOverrideTheme: CupertinoThemeData(
          barBackgroundColor: backgroundColor,
          primaryColor: primary,
          brightness: Brightness.light,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ));
  }

  static ThemeData dark({
    Color accentColor,
  }) {
    final Color primary = accentColor ?? Color(0xFF8F48C4);
    final Color backgroundColor = Color(0xFF212121);
    final Color dividerColor = Color(0xFF444444);
    final Color unselectedColor = Colors.grey;

    return ThemeData(
//        primaryColor: primary,
      accentColor: primary,
      brightness: Brightness.dark,
      toggleableActiveColor: primary.lighten(),
      scaffoldBackgroundColor: backgroundColor,
      primaryColorBrightness: Brightness.dark,
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: 15,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: backgroundColor,
        brightness: Brightness.dark,
      ),
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        height: 50,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        color: dividerColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: Colors.grey[850],
      ),
      tabBarTheme: TabBarTheme(
        labelColor: primary.lighten(15),
        unselectedLabelColor: unselectedColor,
      ),
      indicatorColor: primary.lighten(15),
      cursorColor: primary,
      textSelectionColor: primary.withOpacity(0.3),
      textSelectionHandleColor: primary.darken(20),
    );
  }
}
