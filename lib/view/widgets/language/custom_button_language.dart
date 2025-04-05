import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_route_name.dart';
import '../../../locale/local_controller.dart';

class CustomButtonLanguage extends GetView<LocalController> {
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
          controller.changeLang(languageCode);
          Get.offAllNamed(AppRouteName.layout);
        });
  }
}
