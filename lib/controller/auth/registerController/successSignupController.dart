import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:get/get.dart';

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
