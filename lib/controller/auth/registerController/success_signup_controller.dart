import 'package:get/get.dart';

import '../../../core/constants/app_route_name.dart';

abstract class AppSuccessSignUp extends GetxController {
  goToLogin();
}

class AppSuccessSignUpImp extends AppSuccessSignUp {
  @override
  goToLogin() {
    Get.offAllNamed(AppRouteName.login);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
