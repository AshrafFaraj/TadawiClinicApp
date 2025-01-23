import 'package:neurology_clinic/controller/auth/forgetPasswordController/verfiyCodeController.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthAppbar.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthOtpFeild.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthInfo.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthTitle.dart';
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
              controller.goToResetPassword();
            }),
          ],
        ),
      ),
    );
  }
}
