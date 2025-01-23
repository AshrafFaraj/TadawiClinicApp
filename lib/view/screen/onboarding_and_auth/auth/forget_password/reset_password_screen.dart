import 'package:neurology_clinic/controller/auth/forgetPasswordController/resetPasswordController.dart';
import 'package:neurology_clinic/core/functions/valid_input.dart';
import 'package:neurology_clinic/view/widget/Auth/custom_auth_appbar.dart';
import 'package:neurology_clinic/view/widget/Auth/custom_auth_info.dart';
import 'package:neurology_clinic/view/widget/Auth/custom_auth_textfeild.dart';
import 'package:neurology_clinic/view/widget/Auth/custom_auth_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/widget/onboarding/custom_auth_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // AppResetPasswordControllerImp controller =
    //     Get.put(AppResetPasswordControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: ""),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: ListView(
          children: [
            const CustomAuthTitle(textTitle: "تغيير كلمة السر"),
            const CustomAuthInfo(textInfo: "قمت بادخال كلمة السر الجديدة"),
            GetBuilder<AppResetPasswordControllerImp>(
              builder: (controller) => Column(
                children: [
                  CustomTextFormFeildAuth(
                      validator: (val) {
                        return validInput(val!, 8, 30, "password");
                      },
                      mycontroller: controller.newPassword,
                      isObscure: controller.isObscure,
                      suffixIcon: InkWell(
                        onTap: controller.showPassword,
                        child: controller.iconEye,
                      ),
                      hintText: "ادخل كلمة السر الجديدة"),
                  CustomTextFormFeildAuth(
                      validator: (val) {
                        return validInput(val!, 8, 30, "password");
                      },
                      mycontroller: controller.rePassword,
                      isObscure: controller.isObscure,
                      suffixIcon: InkWell(
                        onTap: controller.showPassword,
                        child: controller.iconEye,
                      ),
                      hintText: "أعد كتابة كلمة السر للتأكيد"),
                  CustomAuthBotton(
                      onPressed: controller.goToSuccessResetPassword,
                      title: "تغيير"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
