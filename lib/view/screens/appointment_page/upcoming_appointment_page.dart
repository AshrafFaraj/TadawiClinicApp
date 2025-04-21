import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/link_api.dart';

import '/controller/appointment/upcoming_appointment_controller.dart';
import '/core/constants/app_route_name.dart';
import '/core/functions/dialog_functions.dart';
import '../../widgets/appointment/appointment_card_widget.dart';
import '../../../core/layouts/app_layout.dart';

class UpcomingAppointmentsPage extends StatefulWidget {
  const UpcomingAppointmentsPage({Key? key}) : super(key: key);

  @override
  State<UpcomingAppointmentsPage> createState() =>
      _UpcomingAppointmentsPageState();
}

class _UpcomingAppointmentsPageState extends State<UpcomingAppointmentsPage>
    with AutomaticKeepAliveClientMixin {
  late UpcomingAppointmentController upcomingAppointmentController;

  @override
  void initState() {
    upcomingAppointmentController = Get.find<UpcomingAppointmentController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      upcomingAppointmentController.initial();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    // Get.put(UpcomingAppointmentController());
    super.build(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await upcomingAppointmentController.checkConnectionFetching();
        },
        child: GetBuilder<UpcomingAppointmentController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.upcomingAppointments.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text("لا توجد مواعيد قادمة"),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.upcomingAppointments.length,
                itemBuilder: (context, index) {
                  final appointment = controller.upcomingAppointments[index];
                  return AppointmentCardWidget(
                    onOutlinedPressed: () {
                      showWarningDialog(
                          context: context,
                          title: 'question'.tr,
                          desc: 'desc'.tr,
                          btnCancelText: 'cancelMs'.tr,
                          btnOkText: 'ok'.tr,
                          btnOkOnPress: () {
                            controller.deleteAppointmet(appointment.id);
                          });
                    },
                    onElevatedPressed: () async {
                      final result = await Get.toNamed(
                          AppRouteName.bookAppointmentPage,
                          arguments: {
                            'action': 'update',
                            'booking': appointment
                          });
                      if (result != null) {
                        controller.fetchUpcomingAppointmentFromServer();
                      }
                    },
                    size: size,
                    color: color,
                    appointment: appointment,
                    status: "pending".tr,
                    outlinedText: "reshedule".tr,
                    buttonText: "cancel".tr,
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: GetBuilder<UpcomingAppointmentController>(
        builder: (controller) {
          return Stack(
            children: [
              // Other content of the screen
              Positioned(
                bottom: 80, // Increase to move higher, decrease to move lower
                right: 18, // To adjust the horizontal position
                child: FloatingActionButton(
                  onPressed: () async {
                    final result = await Get.toNamed(
                      AppRouteName.doctorsPage,
                    );

                    if (result != null) {
                      controller.fetchUpcomingAppointmentFromServer();
                    }
                    // Get.toNamed(AppRouteName.doctorsPage);
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
