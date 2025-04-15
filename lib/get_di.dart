import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/past_appointments_controller.dart';
import 'package:neurology_clinic/controller/appointment/upcoming_appointment_controller.dart';

Future<void> iniDi()async {
  Get.lazyPut(
    () => UpcomingAppointmentController(),
    fenix: true
  );
  Get.lazyPut(
    () => PastAppointmentController(),
    fenix: true
  );

}
