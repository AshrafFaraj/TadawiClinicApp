import 'package:get/get.dart';

import 'controller/auth/loginController/login_controller.dart';
import 'controller/auth/registerController/register_controller.dart';
import 'core/class/curd.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppSignUpControllerImp(), fenix: true);
    Get.lazyPut(() => AppLoginControllerImp(), fenix: true);
    Get.put(Curd());
  }
}
