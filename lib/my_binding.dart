import 'package:get/get.dart';
import 'package:neurology_clinic/controller/book_appointment/book_appointment_controller.dart';
import '/controller/app_layout/app_layout_controller.dart';
import 'controller/home_controller/home_controller.dart';
import 'controller/auth/loginController/login_controller.dart';
import 'controller/auth/registerController/register_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppSignUpControllerImp(), fenix: true);
    Get.lazyPut(() => AppLoginControllerImp(), fenix: true);
    Get.lazyPut(() => LayoutPageController(), fenix: true);
    Get.lazyPut(() => BookAppointmentController(), fenix: true);
    // Get.put(Curd());
    Get.put(HomeController());
  }
}
