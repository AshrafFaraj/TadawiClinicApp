import '/controller/auth/registerController/success_signup_controller.dart';
import '/view/widgets/Auth/custom_auth_appbar.dart';
import '/view/widgets/Auth/custom_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/constants/app_color.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSuccessSignUpImp controller = Get.put(AppSuccessSignUpImp());
    return Scaffold(
      appBar: customAppBar(title: "Success"),
      body: Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 200,
              color: AppColor.primaycolor,
            ),
            const Spacer(),
            SizedBox(
                width: double.infinity,
                child: CustomAuthButton(
                  text: "الذهاب الي تسجيل الدخول",
                  onPressed: () {
                    controller.goToLogin();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
