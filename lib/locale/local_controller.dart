import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme.dart';

class LocalController extends GetxController {
  // Locale initialLang =
  //     myServices.sharedPreferences.getString("langCode") == null
  //         ? Get.deviceLocale!
  //         : Locale(myServices.sharedPreferences.getString("langCode")!);

  Locale? language;
  ThemeData? appTheme;
  // void changeLang(String languageCode) {
  //   Locale locale = Locale(languageCode);
  //   myServices.sharedPreferences.setString("langCode", languageCode);
  //   appTheme = languageCode == "ar" ? themeArabic : themeEnglish;
  //   Get.changeTheme(appTheme);

  //   Get.updateLocale(locale);
  // }

  @override
  void onInit() {
    String? langCode = 'ar';
    if (langCode == "ar") {
      language = Locale(langCode);
      appTheme = themeArabic;

      Get.changeTheme(appTheme!);
      super.onInit();
    }
  }
}
