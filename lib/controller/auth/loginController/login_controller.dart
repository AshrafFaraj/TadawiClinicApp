import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;

import '/core/constants/app_route_name.dart';
import '/link_api.dart';
import '/services/services.dart';

abstract class AppLoginController extends GetxController {
  login();
  showPassword();
}

class AppLoginControllerImp extends AppLoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isObscure = true;
  Icon iconEye = const Icon(Icons.visibility_off_outlined);
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  showPassword() {
    isObscure
        ? {isObscure = false: iconEye = const Icon(Icons.visibility_outlined)}
        : {
            isObscure = true: iconEye =
                const Icon(Icons.visibility_off_outlined)
          };
    update();
  }

  @override
  // دالة تسجيل الدخول
  login() async {
    isShowLoading = true;
    isShowConfetti = true;
    update();
    try {
      final response = await http.post(
        Uri.parse(AppLink.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // حفظ بيانات المستخدم والتوكن محليًا باستخدام Hive
        MyServices myServices = Get.find();
        await myServices.storeData('userData', data);
        check.fire();
        Future.delayed(const Duration(seconds: 2), () {
          isShowLoading = false;
          update();
          confetti.fire();
        });
        Get.snackbar("نجاح", "تم تسجيل الدخول بنجاح!");
        Get.offAllNamed(AppRouteName.home);
      } else {
        // في حالة حصول خطأ مثلاً: صلاحية غير كافية أو بيانات غير صحيحة
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          isShowLoading = false;
          update();
        });

        final errorData = jsonDecode(response.body);
        Get.snackbar("خطأ", errorData['message'] ?? "خطأ أثناء تسجيل الدخول");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");

      Future.delayed(const Duration(seconds: 2), () {
        isShowLoading = false;
        update();
      });
    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
