import 'package:neurology_clinic/controller/auth/registerController/registerController.dart';
import 'package:neurology_clinic/core/class/curd.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppSignUpControllerImp(), fenix: true);
    Get.put(Curd());
  }
}
