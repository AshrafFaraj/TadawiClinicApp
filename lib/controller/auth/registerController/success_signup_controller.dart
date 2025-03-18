import 'package:get/get.dart';

import '../../../core/constants/app_route_name.dart';

abstract class AppSuccessSignUp extends GetxController {
  goToHome();
}

class AppSuccessSignUpImp extends AppSuccessSignUp {
  @override
  goToHome() {
    Get.offAllNamed(AppRouteName.home);
  }
}
