import 'package:neurology_clinic/core/constant/app_color.dart';
import 'package:neurology_clinic/core/localizations/change_locale_controller.dart';
import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonLanguage extends GetView<LocaleController> {
  const CustomButtonLanguage(
      {super.key, required this.language, required this.languageCode});
  final String language;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: AppColor.primaycolor,
        child: Text(
          language,
        ),
        onPressed: () {
          controller.changelanguage(languageCode);
          Get.offAllNamed(AppRouteName.onBoarding);
        });
  }
}
