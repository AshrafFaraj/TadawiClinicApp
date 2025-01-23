import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
