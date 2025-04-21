import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/app_theme.dart';
import 'package:neurology_clinic/controller/appointment/appointments_controller.dart';
import 'package:neurology_clinic/controller/appointment/past_appointments_controller.dart';

import '../../../controller/appointment/upcoming_appointment_controller.dart';
import '/core/constants/app_route_name.dart';
import '../../widgets/appointment/appointment_card_widget.dart';

class PastAppointmentsPage extends StatefulWidget {
  const PastAppointmentsPage({Key? key}) : super(key: key);

  @override
  State<PastAppointmentsPage> createState() => _PastAppointmentsPageState();
}

class _PastAppointmentsPageState extends State<PastAppointmentsPage>
    with AutomaticKeepAliveClientMixin {
  late PastAppointmentController pastAppointmentController;
  @override
  void initState() {
    pastAppointmentController = Get.find<PastAppointmentController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pastAppointmentController.initial();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    // Get.put(PastAppointmentController());
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await pastAppointmentController.checkFetching();
      },
      child: GetBuilder<PastAppointmentController>(builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.pastAppointments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_busy, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  "ليس لديك مواعيد مكتملة",
                  style: themeArabic.textTheme.bodyLarge,
                ),
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
                  onElevatedPressed: () async {
                    final result = await Get.toNamed(
                        AppRouteName.bookAppointmentPage,
                        arguments: {
                          'doctorId': appointment.doctorId,
                          'action': 'new',
                        });

                    if (result != null) {
                      final appointmentController =
                          Get.find<AppointmentController>();
                      final upcomingController =
                          Get.find<UpcomingAppointmentController>();
                      appointmentController.switchToUpcomingTab();
                      upcomingController.fetchUpcomingAppointmentFromServer();
                    }
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
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
