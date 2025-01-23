import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

abstract class AppLoginController extends GetxController {
  getRiveController(Artboard artboard);
  login();
  goToSignUp();
  goToForgetPass();
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

  @override
  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  void login() {
    isShowLoading = true;
    isShowConfetti = true;
    update();
    Future.delayed(const Duration(seconds: 1), () {
      if (formState.currentState!.validate()) {
        // show success
        check.fire();
        Future.delayed(const Duration(seconds: 2), () {
          isShowLoading = false;
          update();
          confetti.fire();
        });
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          isShowLoading = false;
          update();
        });
      }
    });
  }

  @override
  goToSignUp() {
    Get.toNamed(AppRouteName.signUp);
  }

  @override
  goToForgetPass() {
    Get.toNamed(AppRouteName.forgetPassword);
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

  @override
  showPassword() {
    isObscure
        ? {isObscure = false: iconEye = Icon(Icons.visibility_outlined)}
        : {isObscure = true: iconEye = Icon(Icons.visibility_off_outlined)};
    update();
  }
}
