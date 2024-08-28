import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: white,
  scaffoldBackgroundColor: white,
  cardColor: lightError,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: darkColor),
    bodyMedium: TextStyle(color: darkColor),
    bodySmall: TextStyle(color: darkColor),
    displaySmall: TextStyle(color: darkColor),
  ),
  colorScheme: const ColorScheme.light(
    primary: white,
    secondary: red,
    onError: darkError,
  ).copyWith(background: white),
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
  ).copyWith(background: darkColor),
);
