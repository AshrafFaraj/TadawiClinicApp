import 'package:neurology_clinic/core/constant/app_color.dart';
import 'package:neurology_clinic/view/screen/widget/Auth/customAuthAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/datasource/static/appRouteName.dart';
import '../../../widget/onboarding/customAuthButton.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: CustomAuthBotton(
                  title: "الذهاب لتسجيل الدخول",
                  onPressed: () {
                    Get.offAllNamed(AppRouteName.onBoarding);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
