import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/past_appointments_controller.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';
import 'package:neurology_clinic/view/widgets/appointment/Appointment_card_widget.dart';

import '../../../core/constants/app_svg.dart';
import '../../widgets/appointment/empty_appointmets_widget.dart';

class PastAppointmentsPage extends StatelessWidget {
  const PastAppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    // return AppointmentCardWidget(size: size, color: color);
    Get.put(PastAppointmentController());
    return GetBuilder<PastAppointmentController>(
      builder: (controller) {
        if (controller.status == AppointmentStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.status == AppointmentStatus.success) {
          return ListView.builder(
            itemCount: controller.bookings.length,
            itemBuilder: (context, index) {
              if (controller.bookings.isNotEmpty) {
                return AppointmentCardWidget(
                    onOutlinedPressed: () {
                      Get.toNamed(AppRouteName.prescription,
                          arguments: {'booking': controller.bookings[index]});
                    },
                    onElevatedPressed: () {
                      print(controller.bookings[index].id);
                    },
                    status: "completed".tr,
                    outlinedText: "reshedule".tr,
                    buttonText: "prescriptions".tr,
                    size: size,
                    color: color,
                    booking: controller.bookings[index]);
              } else {
                return EmptyAppointmentsWidget(
                    size: size,
                    onPressed: () {
                      Get.toNamed(AppRouteName.bookAppointmentPage);
                    },
                    text: " لا يوجد حجوزات قم بانشاء حجز جديد",
                    assetName: AppSvg.doctors,
                    width: 200);
              }
            },
          );
        }
        return Center(
          child: Text("something went wrong"),
        );
      },
    );
  }
}
