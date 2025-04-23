import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/app_route_name.dart';
import '../../../link_api.dart';

abstract class AppForgetPasswordController extends GetxController {
  // ignore: non_constant_identifier_names
  checkEmail();
}

class AppForgetPasswordControllerImp extends AppForgetPasswordController {
  late TextEditingController email;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Future<void> checkEmail() async {
    try {
      FormState? formData = formState.currentState;
      if (formData!.validate()) {
        final response = await http.post(
          Uri.parse(AppLink.sendResetPasswordOtp),
          headers: {
            "Content-Type": "application/json",
            "User-Agent": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({
            "email": email.text,
          }),
        );
        final data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          Get.snackbar("نجاح", data['message']);
          Get.offAndToNamed(AppRouteName.verfiyCode, arguments: {
            'email': email.text,
            'nextRoute': AppRouteName.resetPassword,
          });
        } else {
          Get.snackbar("فشل", data['message']);
        }
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
