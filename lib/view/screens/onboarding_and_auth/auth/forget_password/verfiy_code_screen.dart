import '/controller/auth/forgetPasswordController/verfiy_code_controller.dart';
import '/view/widgets/Auth/custom_auth_appbar.dart';
import '/view/widgets/Auth/custom_auth_otp_feild.dart';
import '/view/widgets/Auth/custom_auth_info.dart';
import '/view/widgets/Auth/custom_auth_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerfiyCode extends StatelessWidget {
  const VerfiyCode({super.key});

  @override
  Widget build(BuildContext context) {
    AppVerfiyCodeControllerImp controller =
        Get.put(AppVerfiyCodeControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: ""),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: ListView(
          children: [
            const CustomAuthTitle(textTitle: "كود التحقق"),
            const CustomAuthInfo(
                textInfo:
                    "قمت بإدخال كود التحقق الذي تم ارساله الي بريدك الإلكتروني"),
            CustomOtpFeildAuth(onSubmit: (String verificationCode) {
              controller.verifyOtp(verificationCode);
            }),
          ],
        ),
      ),
    );
  }
}
