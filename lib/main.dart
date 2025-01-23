// ignore_for_file: deprecated_member_use
import 'package:neurology_clinic/core/localizations/change_locale_controller.dart';
import 'package:neurology_clinic/core/localizations/translations.dart';
import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:neurology_clinic/my_binding.dart';
import 'package:neurology_clinic/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(/*  */ {super.key});
  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.put(LocaleController());

    return GetMaterialApp(
      // theme: appTheme(),
      debugShowCheckedModeBanner: false,
      locale: localeController.language,
      translations: AppTranslation(),
      initialBinding: MyBinding(),
      initialRoute: AppRouteName.language,
      getPages: routes,
    );
  }
}
