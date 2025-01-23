import 'package:neurology_clinic/core/services/services.dart';
import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("onboarding") == "1") {
      return const RouteSettings(name: AppRouteName.login);
    }
  }
}
