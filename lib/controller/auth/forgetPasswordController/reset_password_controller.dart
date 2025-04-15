import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:neurology_clinic/services/services.dart';

import '../../../core/constants/app_route_name.dart';
import '../../../link_api.dart';

abstract class AppResetPasswordController extends GetxController {
  resetPassword();
  changePassword();
  void showPassword();
}

class AppResetPasswordControllerImp extends AppResetPasswordController {
  MyServices _myServices = Get.find<MyServices>();
  late TextEditingController oldPassword;
  late TextEditingController newPassword;
  late TextEditingController rePassword;
  late String _token;
  String? email;
  String? reasonResetPassword;
  Icon iconEye = const Icon(Icons.visibility_off_outlined);
  bool isObscure = true;
  bool isloading = false;

  @override
  void onInit() {
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
    rePassword = TextEditingController();
    email = Get.arguments['email'];
    reasonResetPassword = Get.arguments['reason'];
    _token = _myServices.userData['token'];
    super.onInit();
  }

  @override
  void resetPassword() async {
    if (newPassword.value != rePassword.value) {
      return Get.defaultDialog(
          title: "خطأ",
          middleText: "كلمة المرور غير متطابقة قمت باعادة كتابتها");
    }
    isloading = true;
    update();
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
        isloading = false;
        update();
        Get.snackbar("فشل", data['message']);
      }
    } catch (e) {
      isloading = false;
      update();
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");
    }
  }

  @override
  void changePassword() async {
    if (newPassword.value != rePassword.value) {
      Get.defaultDialog(
          title: "خطأ",
          middleText: "كلمة المرور غير متطابقة قمت باعادة كتابتها");
    }
    isloading = true;
    update();
    try {
      final response = await http.post(
        Uri.parse(AppLink.changePassword),
        headers: {
          'Authorization': "Bearer $_token",
          "Content-Type": "application/json",
          "User-Agent": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "current_password": oldPassword.text,
          "new_password": newPassword.text,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("نجاح", data['message']);
        Get.offAndToNamed(AppRouteName.successResetPassword);
      } else {
        isloading = false;
        update();
        Get.snackbar("فشل", data['message']);
      }
    } catch (e) {
      isloading = false;
      update();
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");
    }
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

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    rePassword.dispose();
    super.dispose();
  }
}
