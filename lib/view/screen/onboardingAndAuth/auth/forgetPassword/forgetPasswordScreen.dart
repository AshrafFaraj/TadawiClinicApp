import 'package:neurology_clinic/controller/auth/forgetPasswordController/forgetPasswordController.dart';
import 'package:neurology_clinic/core/functions/valid_input.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthAppbar.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthInfo.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthTextFeild.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthTitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/onboarding/customAuthButton.dart';

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
            const CustomAuthInfo(
                textInfo:
                    "قم بكتابة بريدك الإلكتروني او رقم هاتفك الذي استخدمته لإنشاء حسابك"),
            CustomTextFormFeildAuth(
                validator: (val) {
                  return validInput(val!, 12, 30, "email");
                },
                mycontroller: controller.emailController,
                suffixIcon: const Icon(Icons.email_outlined),
                hintText: "ادخل بريدك الالكتروني أو رقم هاتفك"),
            CustomAuthBotton(
              title: "Check",
              onPressed: () {
                controller.goToVerfiyCode();
              },
            ),
          ],
        ),
      ),
    );
  }
}
