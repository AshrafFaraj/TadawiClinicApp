import 'package:neurology_clinic/controller/auth/registerController/register_controller.dart';
import 'package:neurology_clinic/core/class/curd.dart';
import 'package:get/get.dart';

import 'controller/auth/loginController/login_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppSignUpControllerImp(), fenix: true);
    Get.lazyPut(() => AppLoginControllerImp(), fenix: true);
    Get.put(Curd());
  }
}
