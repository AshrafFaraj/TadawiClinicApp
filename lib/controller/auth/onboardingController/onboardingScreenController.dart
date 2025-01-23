import 'package:get/get.dart';
import 'package:rive/rive.dart';

abstract class OnBoardingScreenController extends GetxController {
  letsGo();
  changeIsSignInDialogShown(bool val);
}

class OnBoardingScreenControllerImp extends OnBoardingScreenController {
  bool isSignInDialogShown = false;
  late RiveAnimationController btnAnimationController;

  @override
  letsGo() {}
  @override
  void onInit() {
    btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.onInit();
  }

  @override
  changeIsSignInDialogShown(bool val) {
    isSignInDialogShown = val;
    update();
  }
}
