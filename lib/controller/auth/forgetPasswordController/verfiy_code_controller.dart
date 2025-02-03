import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_route_name.dart';

abstract class AppVerfiyCodeController extends GetxController {
  checkCode();
  goToResetPassword();
}

class AppVerfiyCodeControllerImp extends AppVerfiyCodeController {
  late TextEditingController emailController;

  @override
  checkCode() {
    throw UnimplementedError();
  }

  @override
  goToResetPassword() {
    Get.offAndToNamed(AppRouteName.resetPassword);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
