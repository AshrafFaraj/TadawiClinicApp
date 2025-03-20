import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/link_api.dart';
import 'package:neurology_clinic/services/services.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/constants/app_route_name.dart';

abstract class AppSignUpController extends GetxController {
  register();
  showPassword();
}

class AppSignUpControllerImp extends AppSignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController mobile;
  late TextEditingController address;
  late TextEditingController age;

  String selectedBloodType = '';
  String selectedGender = '';

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  final List<String> genders = ['ذكر', 'أنثى'];

  void selectBloodType(String type) {
    selectedBloodType = type;
    update();
  }

  void selectGender(String gender) {
    selectedGender = gender;
    update();
  }

  bool isObscure = true;
  Icon iconEye = const Icon(Icons.visibility_off_outlined);
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

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  // دالة التسجيل
  @override
  register() async {
    if (selectedBloodType.isEmpty || selectedGender.isEmpty) {
      Get.snackbar('خطأ', 'يرجى اختيار جميع الحقول',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    FormState? formData = formState.currentState;
    if (formData!.validate()) {
      isShowLoading = true;
      isShowConfetti = true;
      update();

      try {
        await http
            .post(
          Uri.parse(AppLink.register),
          headers: {
            "Content-Type": "application/json",
            "User-Agent": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({
            "name": name.text,
            "email": email.text,
            "password": password.text,
            "age": age.text,
            "address": address.text,
            "gender": selectedGender == 'ذكر' ? 'male' : 'female',
            "mobile": mobile.text,
            "blood_type": selectedBloodType,
          }),
        )
            .then(
          (response) async {
            if (response.statusCode == 201) {
              Map data = jsonDecode(response.body);
              MyServices myServices = Get.find();
              // حفظ البيانات محليًا
              userInfoStore(data: data, myServices: myServices);

              Get.snackbar("نجاح", "تم تسجيل الحساب بنجاح!");
              check.fire();
              Future.delayed(const Duration(seconds: 2), () {
                isShowLoading = false;
                update();
                confetti.fire();
              });
              Get.toNamed(AppRouteName.verfiyCode, arguments: {
                'email': email.text,
                'nextRoute': AppRouteName.successSignUp
              });
            } else {
              error.fire();
              Future.delayed(const Duration(seconds: 2), () {
                isShowLoading = false;
                update();
              });
              final errorData = jsonDecode(response.body);
              Get.snackbar("خطأ", errorData['message']);
            }
          },
        );
      } catch (e) {
        Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");
        Future.delayed(const Duration(seconds: 2), () {
          isShowLoading = false;
          update();
        });
      }
    }
  }

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    mobile = TextEditingController();
    password = TextEditingController();
    address = TextEditingController();
    age = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    mobile.dispose();
    address.dispose();
    password.dispose();
    age.dispose();
    super.dispose();
  }
}

void userInfoStore({required Map data, required MyServices myServices}) async {
  // await myServices.sharedPreferences.setString('token', data['token']);
  await myServices.sharedPreferences.setInt('user_id', data['user']['id']);
  await myServices.sharedPreferences.setString('name', data['user']['name']);
  await myServices.sharedPreferences.setString('email', data['user']['email']);
  await myServices.sharedPreferences
      .setString('gender', data['user']['gender']);
  await myServices.sharedPreferences
      .setString('mobile', data['user']['mobile']);
  await myServices.sharedPreferences.setInt('age', data['age']);
  await myServices.sharedPreferences.setString('address', data['address']);
  await myServices.sharedPreferences
      .setString('blood_type', data['blood_type']);
}
