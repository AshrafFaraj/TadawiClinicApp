import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/auth/forgetPasswordController/forget_password_controller.dart';
import '/core/functions/valid_input.dart';
import '/view/widgets/Auth/custom_auth_appbar.dart';
import '/view/widgets/Auth/custom_auth_info.dart';
import '/view/widgets/Auth/custom_auth_textfeild.dart';
import '/view/widgets/Auth/custom_auth_title.dart';
import '../../../../widgets/onboarding_and_auth/custom_auth_button.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    AppForgetPasswordControllerImp controller =
        Get.put(AppForgetPasswordControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: ''),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: CustomAuthTitle(textTitle: "التحقق من وجود الحساب"),
            ),
            const CustomAuthInfo(textInfo: "قم بكتابة بريدك الإلكتروني"),
            Form(
              key: controller.formState,
              child: CustomTextFormFeildAuth(
                  validator: (val) {
                    return validInput(val!, 12, 30, "email");
                  },
                  mycontroller: controller.email,
                  suffixIcon: const Icon(Icons.email_outlined),
                  hintText: "البريد الالكتروني"),
            ),
            CustomAuthBotton(
              title: "تأكيد",
              onPressed: () {
                controller.checkEmail();
              },
            ),
          ],
        ),
      ),
    );
  }
}
