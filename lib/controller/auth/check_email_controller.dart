import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_route_name.dart';

abstract class AppCheckEmailController extends GetxController {
  checkEmail();
  goToSuccessSignUp();
}

class AppCheckEmailControllerImp extends AppCheckEmailController {
  late TextEditingController emailController;

  @override
  checkEmail() {
    throw UnimplementedError();
  }

  @override
  goToSuccessSignUp() {
    Get.offAllNamed(AppRouteName.successSignUp);
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
