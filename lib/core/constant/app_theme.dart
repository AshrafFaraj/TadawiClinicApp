import 'package:neurology_clinic/core/constant/app_color.dart';
import 'package:neurology_clinic/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

MyServices myServices = Get.find();

ThemeData themeArabic = ThemeData(
    fontFamily: "Cairo",
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        color: AppColor.grey,
        height: 1.5,
      ),
    ));

ThemeData themeEnglish = ThemeData(
    fontFamily: "PlayfairDisplay",
    textTheme: const TextTheme(
      headline1: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        color: AppColor.grey,
        height: 1.5,
      ),
    ));

ThemeData? appTheme() {
  String? sharedPrefLang = myServices.sharedPreferences.getString("langCode");
  if (sharedPrefLang == "ar") {
    return themeArabic;
  } else if (sharedPrefLang == "en") {
    return themeEnglish;
  } else {
    if (Locale(Get.deviceLocale!.languageCode) == "ar") {
      return themeArabic;
    } else if (sharedPrefLang == "en") {
      return themeEnglish;
    }
  }
}
