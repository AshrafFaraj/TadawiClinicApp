import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/app_route_name.dart';
import '../../../link_api.dart';

abstract class AppResetPasswordController extends GetxController {
  resetPassword();
  void showPassword();
}

class AppResetPasswordControllerImp extends AppResetPasswordController {
  late TextEditingController newPassword;
  late TextEditingController rePassword;
  String? email;
  Icon iconEye = const Icon(Icons.visibility_off_outlined);
  bool isObscure = true;

  @override
  resetPassword() async {
    if (newPassword.value != rePassword.value) {
      return Get.defaultDialog(
          title: "خطأ",
          middleText: "كلمة المرور غير متطابقة قمت باعادة كتابتها");
    }
    try {
      final response = await http.post(
        Uri.parse(AppLink.resetPassword),
        headers: {
          "Content-Type": "application/json",
          "User-Agent": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "email": email,
          "password": rePassword.text,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("نجاح", data['message']);
        Get.offAndToNamed(AppRouteName.successResetPassword);
      } else {
        return Get.snackbar("فشل", data['message']);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");
    }
  }

  @override
  void onInit() {
    newPassword = TextEditingController();
    rePassword = TextEditingController();
    email = Get.arguments['email'];

    super.onInit();
  }

  @override
  void dispose() {
    newPassword.dispose();
    rePassword.dispose();
    super.dispose();
  }

  @override
  void showPassword() {
    isObscure
        ? {isObscure = false: iconEye = const Icon(Icons.visibility_outlined)}
        : {
            isObscure = true: iconEye =
                const Icon(Icons.visibility_off_outlined)
          };
    update();
  }
}
