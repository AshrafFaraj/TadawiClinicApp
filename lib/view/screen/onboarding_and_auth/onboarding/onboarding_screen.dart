import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/widget/onboarding/custom_position_spline_image.dart';
import 'package:neurology_clinic/view/widget/onboarding/custom_position_blurfill.dart';
import 'package:neurology_clinic/view/widget/onboarding/onboarding_text.dart';
import 'package:rive/rive.dart';
import 'package:neurology_clinic/view/widget/onboarding/animated_btn.dart';
import 'package:neurology_clinic/view/widget/onboarding/custom_signin_dialog.dart';
import '../../../../controller/auth/onboardingController/onboardingScreenController.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingScreenControllerImp controller =
        Get.put((OnBoardingScreenControllerImp()));
    return Scaffold(
        body: Stack(
      children: [
        CustomPositionImage(
            bottom: 200,
            left: 100,
            image: Image.asset('assets/Backgrounds/Spline.png'),
            width: MediaQuery.of(context).size.width * 1.7),
        const CustomPositionBlurfill(sigmaX: 20, sigmaY: 10),
        const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
        const CustomPositionBlurfill(
          sigmaX: 20,
          sigmaY: 10,
          child: SizedBox(),
        ),
        const Spacer(
          flex: 1,
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: controller.isSignInDialogShown ? -50 : 0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const OnBoardingText(),
                    const Spacer(
                      flex: 1,
                    ),
                    AnimatedBtn(
                      btnAnimationController: controller.btnAnimationController,
                      press: () {
                        controller.btnAnimationController.isActive = true;
                        Future.delayed(const Duration(milliseconds: 800), () {
                          controller.changeIsSignInDialogShown(true);
                          customSigninDialog(context, onClosed: (_) {
                            controller.changeIsSignInDialogShown(false);
                          });
                        });
                      },
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ]),
            ),
          ),
        )
      ],
    ));
  }
}
