import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/widgets/onboarding_and_auth/build_blood_type_grid.dart';
import 'package:neurology_clinic/view/widgets/onboarding_and_auth/build_gender_options.dart';
import 'package:neurology_clinic/view/widgets/onboarding_and_auth/build_section_title.dart';
import 'package:rive/rive.dart';
import '../../../controller/auth/registerController/register_controller.dart';
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
                                      validator: (val) {
                                        return validInput(val!, 20, 30, "name");
                                      },
                                      mycontroller: controller.name,
                                      suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/email.svg")),
                                      hintText: "اكتب اسمك الكامل",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      mycontroller: controller.email,
                                      validator: (val) {
                                        return validInput(
                                            val!, 12, 30, "email");
                                      },
                                      suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/email.svg")),
                                      hintText: "اكتب بريدك الالكتروني",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                        mycontroller: controller.mobile,
                                        validator: (val) {
                                          return validInput(
                                              val!, 9, 9, "phone");
                                        },
                                        isNumber: true,
                                        suffixIcon: const Icon(
                                            Icons.phone_android_outlined),
                                        hintText: "ادخل رقم الموبايل"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      validator: (val) {
                                        return validInput(val!, 1, 3, "age");
                                      },
                                      mycontroller: controller.age,
                                      suffixIcon:
                                          const Icon(Icons.date_range_outlined),
                                      hintText: "كم هو عمرك",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomTextFormFeildAuth(
                                      mycontroller: controller.password,
                                      validator: (val) {
                                        return validInput(
                                            val!, 8, 15, "password");
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
                                      mycontroller: controller.address,
                                      validator: (val) {
                                        return validInput(
                                            val!, 10, 30, "address");
                                      },
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(Icons.location_city),
                                      ),
                                      hintText: "اكتب عنوانك",
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          const BuildSectionTitle(
                                            title: 'اختر فصيلة الدم',
                                          ),
                                          BuildBloodTypeGrid(
                                            controller: controller,
                                          ),
                                          const SizedBox(height: 20),
                                          const BuildSectionTitle(
                                              title: 'اختر الجنس'),
                                          BuildGenderOptions(
                                            controller: controller,
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 24),
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
