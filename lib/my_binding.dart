import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/past_appointments_controller.dart';
import 'package:neurology_clinic/controller/appointment/upcoming_appointment_controller.dart';
import '/controller/auth/forgetPasswordController/reset_password_controller.dart';
import '/controller/doctor_controller.dart';
import '/controller/app_layout/app_layout_controller.dart';
import 'controller/appointment/appointments_controller.dart';
import 'controller/book_appointment/book_appointment_controller.dart';
import 'controller/home_controller/home_controller.dart';
import 'controller/auth/loginController/login_controller.dart';
import 'controller/auth/registerController/register_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppSignUpControllerImp(), fenix: true);
    Get.lazyPut(() => AppLoginControllerImp(), fenix: true);
    Get.lazyPut(() => AppResetPasswordControllerImp(), fenix: true);
    Get.put(DoctorController());
    Get.lazyPut(() => AppointmentController(), fenix: true);
    Get.lazyPut(() => PastAppointmentController(), fenix: true);
    Get.put(UpcomingAppointmentController());
    Get.put(HomeController());
    Get.put(LayoutPageController());
    Get.lazyPut(() => BookAppointmentController(), fenix: true);
    // Get.put(Curd());
  }
}
