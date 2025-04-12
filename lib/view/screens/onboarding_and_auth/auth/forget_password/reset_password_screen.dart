import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/view/widgets/onboarding_and_auth/custom_auth_button.dart';
import '/controller/auth/forgetPasswordController/reset_password_controller.dart';
import '/core/functions/valid_input.dart';
import '/view/widgets/Auth/custom_auth_textfeild.dart';
import '/view/widgets/Auth/custom_auth_title.dart';

// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        width: double.infinity,
        child: Column(
          children: [
            const CustomAuthTitle(textTitle: "تغيير كلمة السر"),
            const SizedBox(
              height: 50,
            ),
            GetBuilder<AppResetPasswordControllerImp>(builder: (controller) {
              if (controller.isloading) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  controller.reasonResetPassword == 'change'
                      ? CustomTextFormFeildAuth(
                          validator: (val) {
                            return validInput(val!, 8, 15, "password");
                          },
                          mycontroller: controller.oldPassword,
                          isObscure: false,
                          suffixIcon: const Icon(Icons.password_outlined),
                          hintText: "ادخل كلمة المرور القديمة")
                      : controller.reasonResetPassword == 'forget'
                          ? const SizedBox()
                          : const SizedBox(),
                  CustomTextFormFeildAuth(
                      validator: (val) {
                        return validInput(val!, 8, 15, "password");
                      },
                      mycontroller: controller.newPassword,
                      isObscure: controller.isObscure,
                      suffixIcon: InkWell(
                        onTap: controller.showPassword,
                        child: controller.iconEye,
                      ),
                      hintText: "ادخل كلمة المرور الجديدة"),
                  CustomTextFormFeildAuth(
                      validator: (val) {
                        return validInput(val!, 8, 15, "password");
                      },
                      mycontroller: controller.rePassword,
                      isObscure: true,
                      hintText: "أعد كتابة كلمة السر للتأكيد"),
                  CustomAuthBotton(
                      onPressed: controller.reasonResetPassword == 'forget'
                          ? controller.resetPassword
                          : controller.changePassword,
                      title: 'تغيير')
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
