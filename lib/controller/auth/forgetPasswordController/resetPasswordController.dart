import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppResetPasswordController extends GetxController {
  resetPassword();
  goToSuccessResetPassword();
  showPassword();
}

class AppResetPasswordControllerImp extends AppResetPasswordController {
  late TextEditingController newPassword;
  late TextEditingController rePassword;
  Icon iconEye = Icon(Icons.visibility_off_outlined);
  bool isObscure = true;

  @override
  resetPassword() {
    throw UnimplementedError();
  }

  @override
  goToSuccessResetPassword() {
    Get.offAndToNamed(AppRouteName.successResetPassword);
  }

  @override
  void onInit() {
    newPassword = TextEditingController();
    rePassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    newPassword.dispose();
    rePassword.dispose();
    super.dispose();
  }

  @override
  showPassword() {
    isObscure
        ? {isObscure = false: iconEye = Icon(Icons.visibility_outlined)}
        : {isObscure = true: iconEye = Icon(Icons.visibility_off_outlined)};
    update();
  }
}
