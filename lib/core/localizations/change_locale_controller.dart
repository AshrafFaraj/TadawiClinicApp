import 'package:neurology_clinic/core/constant/app_theme.dart';
import 'package:neurology_clinic/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  ThemeData appTheme = themeEnglish;

  changelanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    myServices.sharedPreferences.setString("langCode", languageCode);
    appTheme = languageCode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("langCode");
    if (sharedPrefLang == "ar") {
      language = Locale(sharedPrefLang!);
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = Locale(sharedPrefLang!);
      appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    Get.changeTheme(appTheme);

    super.onInit();
  }
}
