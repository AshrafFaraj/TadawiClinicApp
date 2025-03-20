import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../widgets/onboarding_and_auth/custom_position_blurfill.dart';
import '../../../widgets/onboarding_and_auth/onboarding_text.dart';
import '../../../widgets/onboarding_and_auth/animated_btn.dart';
import '../../../widgets/onboarding_and_auth/custom_signin_dialog.dart';
import '../../../../controller/auth/onboardingController/onboarding_screen_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingScreenControllerImp controller =
        Get.put((OnBoardingScreenControllerImp()));
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset('assets/Backgrounds/Spline.png')),
        const CustomPositionBlurfill(sigmaX: 20, sigmaY: 10),
        const rive.RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
        const CustomPositionBlurfill(
          sigmaX: 20,
          sigmaY: 10,
          child: SizedBox(),
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
