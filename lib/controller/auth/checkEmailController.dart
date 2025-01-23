import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
