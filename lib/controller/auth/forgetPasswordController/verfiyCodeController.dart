import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
