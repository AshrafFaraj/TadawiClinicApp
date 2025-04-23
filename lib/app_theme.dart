import 'package:flutter/material.dart';
import 'package:neurology_clinic/core/layouts/app_color_theme.dart';

ThemeData themeArabic = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    fontFamily: "Cairo",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        letterSpacing: -1,
        wordSpacing: 2,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColorTheme.background2,
      ),
      headlineSmall: TextStyle(
        letterSpacing: -1,
        wordSpacing: 2,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColorTheme.background2,
      ),
      bodyLarge: TextStyle(
        letterSpacing: -1,
        wordSpacing: 2,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColorTheme.shadow,
      ),
      bodyMedium: TextStyle(
        letterSpacing: -1,
        wordSpacing: 2,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColorTheme.background,
        height: 1.5,
      ),
    ));

// ThemeData themeEnglish = ThemeData(
//     colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//     // fontFamily: "PlayfairDisplay",
//     textTheme: const TextTheme(
//       headlineSmall: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//       bodyLarge: TextStyle(
//         fontSize: 15,
//       ),
//       bodyMedium: TextStyle(
//         fontSize: 14,
//         color: AppColor.grey,
//         height: 1.5,
//       ),
//     ));

ThemeData? appTheme() {
  return themeArabic;
}
