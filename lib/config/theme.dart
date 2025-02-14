import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: white,
  scaffoldBackgroundColor: white,
  cardColor: lightError,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: mainDarkColor),
    bodyMedium: TextStyle(color: mainDarkColor),
    bodySmall: TextStyle(color: mainDarkColor),
    displaySmall: TextStyle(color: mainDarkColor),
  ),
  colorScheme: const ColorScheme.light(
    primary: white,
    secondary: red,
    onError: darkError,
  ).copyWith(surface: white),
  textSelectionTheme:
      const TextSelectionThemeData(selectionHandleColor: mainDarkColor),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: mainDarkColor,
  scaffoldBackgroundColor: mainDarkColor,
  cardColor: darkError,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: white),
    bodyMedium: TextStyle(color: white),
  ),
  colorScheme: const ColorScheme.dark(
    primary: mainDarkColor,
    secondary: red,
    onError: lightError,
  ).copyWith(surface: darkColor),
  textSelectionTheme:
      const TextSelectionThemeData(selectionHandleColor: Colors.white),
);
