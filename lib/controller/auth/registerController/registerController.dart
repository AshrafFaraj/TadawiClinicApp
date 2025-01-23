import 'package:neurology_clinic/core/class/status_request.dart';
import 'package:neurology_clinic/core/functions/handling_data.dart';
import 'package:neurology_clinic/data/datasource/remote/signup_data.dart';
import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

abstract class AppSignUpController extends GetxController {
  register();
  signUp();
  goToLogin();
  showPassword();
  radioSexSelect(String sex);
}

class AppSignUpControllerImp extends AppSignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;
  late TextEditingController age;
  late TextEditingController name;
  late TextEditingController password;
  late TextEditingController phone;
  bool isObscure = true;
  Icon iconEye = const Icon(Icons.visibility_off_outlined);
  SignUpData signData = SignUpData(Get.find());
  List data = [];
  late StatusRequest statusRequest;
  String? patientSex;
  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  void register() {
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
  signUp() async {
    FormState? formData = formState.currentState;
    if (formData!.validate()) {
      print("valid");
      statusRequest = StatusRequest.loading;
      var response = await signData.signUpData(
          name.text, password.text, age.text, phone.text);
      print("=========== controller $response");
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          Get.defaultDialog(
              title: "Success", middleText: "Sign Up seccessefully");
          print("Sign Up success");
        } else if (response['status'] == "failure") {
          Get.defaultDialog(
              title: "failure",
              middleText: "Sign Up failure\n${response['message']} is wrong");
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }

  @override
  goToLogin() {
    Get.offAllNamed(AppRouteName.login);
  }

  @override
  radioSexSelect(String? sex) {
    patientSex = sex;
    update();
  }

  @override
  void onInit() {
    name = TextEditingController();
    age = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
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
}
