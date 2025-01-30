import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_route_name.dart';

abstract class AppForgetPasswordController extends GetxController {
  CheckEmail();
  goToVerfiyCode();
}

class AppForgetPasswordControllerImp extends AppForgetPasswordController {
  late TextEditingController emailController;

  @override
  CheckEmail() {
    throw UnimplementedError();
  }

  @override
  goToVerfiyCode() {
    Get.offAndToNamed(AppRouteName.verfiyCode);
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
