import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme.dart';
import '../services/services.dart';


class LocalController extends GetxController {
  // Locale initialLang = sharedpref!.getString("lang") == null
  //     ? Get.deviceLocale!
  //     : Locale(sharedpref!.getString("lang")!);
  Locale? language;
  MyServices myServices = Get.find();
  ThemeData appTheme = themeEnglish;
  void changeLang(String languageCode) {
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
