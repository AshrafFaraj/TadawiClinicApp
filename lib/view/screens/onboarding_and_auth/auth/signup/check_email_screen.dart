import '/controller/auth/check_email_controller.dart';
import '/view/widgets/Auth/custom_auth_appbar.dart';
import '/view/widgets/Auth/custom_auth_otp_feild.dart';
import '/view/widgets/Auth/custom_auth_info.dart';
import '/view/widgets/Auth/custom_auth_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    AppCheckEmailControllerImp controller =
        Get.put(AppCheckEmailControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: "Verfication Code"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: ListView(
          children: [
            const CustomAuthTitle(textTitle: "التحقق من الكود"),
            const CustomAuthInfo(
                textInfo:
                    "قم بإدخال الكود الذي تم ارساله الي بريدك الالكتروني"),
            CustomOtpFeildAuth(onSubmit: (String verificationCode) {
              controller.goToSuccessSignUp();
            }),
          ],
        ),
      ),
    );
  }
}

// class CheckEmail extends StatelessWidget {
//   const CheckEmail({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AppForgetPasswordControllerImp controller =
//         Get.put(AppForgetPasswordControllerImp());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: customAppBar(title: "Check email"),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         width: double.infinity,
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: CustomAuthTitle(textTitle: "Success SignUp"),
//             ),
//             CustomAuthInfo(
//                 textInfo:
//                     "Please enter your email address to active  verfication code"),
//             CustomTextFormFeildAuth(
//                 mycontroller: controller.emailController,
//                 label: "Email",
//                 suffixIcon: Icon(Icons.email_outlined),
//                 hintText: "Enter your email"),
//             CustomAuthButton(
//               text: "Check",
//               onPressed: () {
//                 controller.goToVerfiyCode();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
