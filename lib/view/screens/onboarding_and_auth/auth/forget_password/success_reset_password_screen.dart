import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/view/widgets/Auth/custom_auth_appbar.dart';
import '/core/constants/app_color.dart';
import '/core/constants/app_route_name.dart';
import '../../../../widgets/onboarding_and_auth/custom_auth_button.dart';

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
                    Get.offAllNamed(AppRouteName.home);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
