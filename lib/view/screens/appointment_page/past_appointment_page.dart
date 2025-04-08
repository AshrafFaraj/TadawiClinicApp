import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/constants/app_route_name.dart';
import '/services/services.dart';
import '/view/widgets/appointment/Appointment_card_widget.dart';

class PastAppointmentsPage extends StatelessWidget {
  PastAppointmentsPage({Key? key}) : super(key: key);
  final MyServices myServices = Get.find<MyServices>();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    // return AppointmentCardWidget(size: size, color: color);
    return Obx(() {
      if (myServices.loadingStates['appointmentLoading'] == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (myServices.pastAppointment.isEmpty) {
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
          itemCount: myServices.pastAppointment.length,
          itemBuilder: (context, index) {
            return AppointmentCardWidget(
                onOutlinedPressed: () {
                  Get.toNamed(AppRouteName.prescription, arguments: {
                    'booking': myServices.pastAppointment[index]
                  });
                },
                onElevatedPressed: () {
                  print(myServices.pastAppointment[index].id);
                },
                status: "completed".tr,
                outlinedText: "reshedule".tr,
                buttonText: "prescriptions".tr,
                size: size,
                color: color,
                appointment: myServices.pastAppointment[index]);
          },
        );
      }
    });
  }
}
