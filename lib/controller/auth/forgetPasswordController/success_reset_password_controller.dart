import 'package:get/get.dart';

import '../../../core/constants/app_route_name.dart';

abstract class _AppSuccessResetPassword extends GetxController {
  goToLogin();
}

class AppSuccessResetPasswordImp extends _AppSuccessResetPassword {
  @override
  goToLogin() {
    Get.offAllNamed(AppRouteName.onBoarding);
  }
}
