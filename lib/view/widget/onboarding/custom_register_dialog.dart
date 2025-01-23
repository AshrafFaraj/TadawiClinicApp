import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/auth/registerController/registerController.dart';
import 'package:rive/rive.dart';
import '../../../core/functions/valid_input.dart';
import '../Auth/custom_auth_textfeild.dart';
import '../Auth/custom_auth_question.dart';
import '../Auth/custom_auth_info.dart';
import '../Auth/custom_auth_title.dart';
import 'custom_auth_button.dart';
import 'custom_position_trigger.dart';
import 'custom_signin_dialog.dart';

Future<Object?> customRegisterDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
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
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height - 150,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset:
                    false, // avoid overflow error when keyboard shows up
                body: GetBuilder<AppSignUpControllerImp>(builder: (controller) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SingleChildScrollView(
                        child: Column(children: [
                          const CustomAuthTitle(textTitle: "إنشاء حساب"),
                          const CustomAuthInfo(
                              textInfo: "قم بتعبئة جميع البيانات التالية"),
                          Form(
                              key: controller.formState,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/email.svg")),
                                      hintText: "اكتب اسمك الكامل",
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                        isNumber: true,
                                        // validator: (val) {
                                        //   return validInput(val!, 9, 9, "phone");
                                        // },
                                        suffixIcon:
                                            Icon(Icons.phone_android_outlined),
                                        hintText: "ادخل رقم الموبايل"),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      suffixIcon:
                                          Icon(Icons.date_range_outlined),
                                      hintText: "كم هو عمرك",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      validator: (val) {
                                        return validInput(
                                            val!, 8, 30, "password");
                                      },
                                      suffixIcon: SvgPicture.asset(
                                          "assets/icons/password.svg"),
                                      hintText: "ادخل كلمة السر",
                                      // mycontroller: controller.password
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      // isObscure: controller.isObscure,
                                      validator: (val) {
                                        return validInput(
                                            val!, 8, 30, "password");
                                      },
                                      suffixIcon: SvgPicture.asset(
                                          "assets/icons/password.svg"),
                                      hintText: "أعد إدخال كلمة السر للتأكيد",
                                      // mycontroller: controller.password
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(" نوع الجنس"),
                                      const Spacer(),
                                      const Text("ذكر"),
                                      Radio(
                                          value: "male",
                                          groupValue: controller.patientSex,
                                          onChanged: (val) {
                                            controller.radioSexSelect(val);
                                          }),
                                      const Text("أنثى"),
                                      Radio(
                                          value: "female",
                                          groupValue: controller.patientSex,
                                          onChanged: (val) {
                                            controller.radioSexSelect(val);
                                          }),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 24),
                                      child: CustomAuthBotton(
                                          onPressed: controller.register,
                                          title: "إنشاء"))
                                ],
                              )),
                          CustomAuthQuestion(
                            constText: "لديك حساب أنشأته في وقت سابق",
                            clickText: "تسجيل الدخول",
                            onTap: () {
                              Navigator.pop(context);
                              customSigninDialog(context, onClosed: onClosed);
                            },
                          ),
                        ]),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: MediaQuery.of(context).size.height - 1030,
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ),
                      Stack(
                        children: [
                          controller.isShowLoading
                              ? CustomPositionedTrigger(
                                  child: RiveAnimation.asset(
                                  "assets/RiveAssets/check.riv",
                                  onInit: (artboard) {
                                    StateMachineController
                                        stateMachineController =
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
                                          stateMachineController = controller
                                              .getRiveController(artboard);
                                      controller.confetti =
                                          stateMachineController
                                                  .findSMI("Trigger explosion")
                                              as SMITrigger;
                                    },
                                  ),
                                ))
                              : const SizedBox()
                        ],
                      ),
                    ],
                  );
                })),
          ),
        );
      }).then(onClosed);
}
