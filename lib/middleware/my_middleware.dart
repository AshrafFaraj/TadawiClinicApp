import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../core/constants/app_route_name.dart';
import '../services/services.dart';

class MyMiddleWare extends GetMiddleware {
  // int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (!myServices.userData.containsKey('token')) {
      return const RouteSettings(name: AppRouteName.onBoarding);
    }
  }
}
