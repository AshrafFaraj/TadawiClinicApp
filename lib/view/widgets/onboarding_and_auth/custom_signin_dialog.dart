import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '/core/constants/app_route_name.dart';
import '/core/functions/valid_input.dart';
import '/view/screens/onboarding_and_auth/auth/forget_password/forget_password_screen.dart';
import 'custom_register_email_or_google.dart';
import '../../../controller/auth/loginController/login_controller.dart';
import '../Auth/custom_auth_textfeild.dart';
import '../Auth/custom_auth_info.dart';
import '../Auth/custom_auth_title.dart';
import '../auth/custom_auth_question.dart';
import 'custom_auth_button.dart';
import 'custom_position_trigger.dart';

Future<Object?> customSigninDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
      barrierLabel: "Sign In",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) {
        // AppLoginControllerImp controller = Get.put(AppLoginControllerImp());
        return Center(
            child: Container(
          height: MediaQuery.of(context).size.height - 150,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset:
                false, // avoid overflow error when keyboard shows up
            body: GetBuilder<AppLoginControllerImp>(builder: (controller) {
              Get.put(ForgetPassword());
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  SingleChildScrollView(
                    child: Column(children: [
                      const CustomAuthTitle(textTitle: "تسجيل الدخول"),
                      const CustomAuthInfo(
                          textInfo:
                              " مرحباً بعودتك \nلديك حساب أنشأته في وقت سابق يمكنك الدخول باستخدام بريدك الالكتروني وكلمة السر"),
                      // const SignInForm(),
                      Form(
                          key: controller.formState,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "البريد الالكتروني",
                                style: TextStyle(color: Colors.black54),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: CustomTextFormFeildAuth(
                                  // validator: (val) {
                                  //   return validInput(val!, 12, 30, "email");
                                  // },
                                  mycontroller: controller.emailController,
                                  suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: SvgPicture.asset(
                                          "assets/icons/email.svg")),
                                  hintText:
                                      "ادخل بريدك الالكتروني أو رقم الهاتف",
                                ),
                              ),
                              const Text(
                                "كلمة المرور",
                                style: TextStyle(color: Colors.black54),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 16),
                                child: CustomTextFormFeildAuth(
                                  validator: (val) {
                                    return validInput(val!, 8, 15, "password");
                                  },
                                  isObscure: controller.isObscure,
                                  mycontroller: controller.passwordController,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.showPassword();
                                      },
                                      icon: controller.iconEye),
                                  hintText: "ادخل كلمة المرور",
                                ),
                              ),
                              CustomAuthQuestion(
                                  constText: "هل نسيت كلمة السر",
                                  clickText: "تغيير",
                                  onTap: () {
                                    Get.toNamed(AppRouteName.forgetPassword);
                                  }),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 24),
                                  child: CustomAuthBotton(
                                      onPressed: controller.login,
                                      title: "دخول"))
                            ],
                          )),
                      const CustomAuthInfo(
                          textInfo:
                              "أو قم بإنشاء حساب وتسجيل بياناتك الشخصية أو استخدم حساب جوجل"),
                      CustomRegisterByEmailOrGoogle(onClosed: onClosed),
                    ]),
                  ),
                  Stack(
                    children: [
                      controller.isShowLoading
                          ? CustomPositionedTrigger(
                              child: RiveAnimation.asset(
                              "assets/RiveAssets/check.riv",
                              onInit: (artboard) {
                                StateMachineController stateMachineController =
                                    controller.getRiveController(artboard);
                                controller.check = stateMachineController
                                    .findSMI("Check") as SMITrigger;
                                controller.error = stateMachineController
                                    .findSMI("Error") as SMITrigger;
                                controller.reset = stateMachineController
                                    .findSMI("Reset") as SMITrigger;
                              },
                            ))
                          : const SizedBox(),
                      controller.isShowConfetti
                          ? CustomPositionedTrigger(
                              child: Transform.scale(
                              scale: 6,
                              child: RiveAnimation.asset(
                                "assets/RiveAssets/confetti.riv",
                                onInit: (artboard) {
                                  StateMachineController
                                      stateMachineController =
                                      controller.getRiveController(artboard);
                                  controller.confetti = stateMachineController
                                          .findSMI("Trigger explosion")
                                      as SMITrigger;
                                },
                              ),
                            ))
                          : const SizedBox()
                    ],
                  )
                ],
              );
            }),
          ),
        ));
      }).then(onClosed);
}
