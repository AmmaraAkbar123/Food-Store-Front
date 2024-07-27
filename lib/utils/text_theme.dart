import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class MyTextTheme {
  MyTextTheme._();

  // Non-constant, customizable light textTheme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: MyColors.dark,
    ),
    headlineMedium: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: MyColors.dark,
    ),
    headlineSmall: TextStyle(
      color: MyColors.black,
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
        fontSize: 24, color: MyColors.black, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: MyColors.dark,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      color: MyColors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: MyColors.dark,
    ),
    bodyMedium: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.normal,
      color: MyColors.dark,
    ),
    bodySmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: MyColors.primary,
    ),
    labelLarge: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: MyColors.dark,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: MyColors.dark,
    ),
  );
}
