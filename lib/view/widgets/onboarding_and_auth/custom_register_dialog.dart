import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '/view/widgets/onboarding_and_auth/build_blood_type_grid.dart';
import '/view/widgets/onboarding_and_auth/build_gender_options.dart';
import '/view/widgets/onboarding_and_auth/build_section_title.dart';
import '../../../controller/auth/registerController/register_controller.dart';
import '../../../core/functions/valid_input.dart';
import '../Auth/custom_auth_textfeild.dart';
import '../Auth/custom_auth_question.dart';
import '../Auth/custom_auth_title.dart';
import 'custom_auth_button.dart';
import 'custom_position_trigger.dart';
import 'custom_login_dialog.dart';

Future<Object?> customRegisterDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
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
            height: MediaQuery.of(context).size.height - 100,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
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
                          Form(
                              key: controller.formState,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFormFeildAuth(
                                    validator: (val) {
                                      return validInput(val!, 20, 30, "name");
                                    },
                                    mycontroller: controller.name,
                                    suffixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(Icons.person_2_outlined)),
                                    hintText: "اكتب اسمك الكامل",
                                  ),
                                  CustomTextFormFeildAuth(
                                    mycontroller: controller.email,
                                    validator: (val) {
                                      return validInput(val!, 12, 30, "email");
                                    },
                                    suffixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(Icons.email_outlined)),
                                    hintText: "اكتب بريدك الالكتروني",
                                  ),
                                  CustomTextFormFeildAuth(
                                    mycontroller: controller.password,
                                    validator: (val) {
                                      return validInput(
                                          val!, 8, 15, "password");
                                    },
                                    suffixIcon:
                                        const Icon(Icons.password_outlined),
                                    hintText: "ادخل كلمة السر",
                                    // mycontroller: controller.password
                                  ),
                                  CustomTextFormFeildAuth(
                                      mycontroller: controller.mobile,
                                      validator: (val) {
                                        return validInput(val!, 9, 9, "phone");
                                      },
                                      isNumber: true,
                                      suffixIcon: const Icon(
                                          Icons.phone_android_outlined),
                                      hintText: "ادخل رقم الموبايل"),
                                  CustomTextFormFeildAuth(
                                    validator: (val) {
                                      return validInput(val!, 1, 3, "age");
                                    },
                                    mycontroller: controller.age,
                                    suffixIcon:
                                        const Icon(Icons.date_range_outlined),
                                    hintText: "كم هو عمرك",
                                  ),
                                  CustomTextFormFeildAuth(
                                    mycontroller: controller.address,
                                    validator: (val) {
                                      return validInput(
                                          val!, 10, 30, "address");
                                    },
                                    suffixIcon: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(Icons.my_location_outlined),
                                    ),
                                    hintText: "اكتب عنوانك",
                                  ),
                                  Column(
                                    children: [
                                      const BuildSectionTitle(
                                        title: 'اختر فصيلة الدم',
                                      ),
                                      BuildBloodTypeGrid(
                                        controller: controller,
                                      ),
                                      const SizedBox(height: 10),
                                      const BuildSectionTitle(
                                          title: 'اختر الجنس'),
                                      BuildGenderOptions(
                                        controller: controller,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 5),
                                      child: CustomAuthBotton(
                                          onPressed: controller.register,
                                          title: "إنشاء"))
                                ],
                              )),
                          CustomAuthQuestion(
                            constText: "هل لديك حساب بالفعل",
                            clickText: "تسجيل الدخول",
                            onTap: () {
                              Navigator.pop(context);
                              customLoginDialog(context, onClosed: onClosed);
                            },
                          ),
                        ]),
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
