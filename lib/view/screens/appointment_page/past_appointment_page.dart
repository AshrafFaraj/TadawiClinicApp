import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/past_appointments_controller.dart';

import '/core/constants/app_route_name.dart';
import '/view/widgets/appointment/Appointment_card_widget.dart';


class PastAppointmentsPage extends StatelessWidget {
  PastAppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    // Get.put(PastAppointmentController());
    return GetBuilder<PastAppointmentController>(builder: (controller) {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.pastAppointments.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_busy, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text("ليس لديك مواعيد مكتملة"),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: controller.pastAppointments.length,
          itemBuilder: (context, index) {
            var appointment = controller.pastAppointments[index];
            return AppointmentCardWidget(
                onOutlinedPressed: () {
                  Get.toNamed(AppRouteName.prescription,
                      arguments: {'booking': appointment});
                },
                onElevatedPressed: () {
                  print(appointment.id);
                },
                status: "completed".tr,
                outlinedText: "reshedule".tr,
                buttonText: "prescriptions".tr,
                size: size,
                color: color,
                appointment: appointment);
          },
        );
      }
    });
  }
}
