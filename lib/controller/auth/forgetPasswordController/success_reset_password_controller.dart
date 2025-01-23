import 'package:get/get.dart';
import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';

abstract class _AppSuccessResetPassword extends GetxController {
  goToLogin();
}

class AppSuccessResetPasswordImp extends _AppSuccessResetPassword {
  @override
  goToLogin() {
    Get.offAllNamed(AppRouteName.onBoarding);
  }
}
