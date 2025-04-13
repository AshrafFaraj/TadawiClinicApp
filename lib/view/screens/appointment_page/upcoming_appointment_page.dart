import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/upcoming_appointment_controller.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';
import 'package:neurology_clinic/core/constants/app_svg.dart';
import 'package:neurology_clinic/core/functions/dialog_functions.dart';
import 'package:neurology_clinic/view/widgets/appointment/Appointment_card_widget.dart';
import '../../widgets/appointment/empty_appointmets_widget.dart';

class UpcomingAppointmentsPage extends StatelessWidget {
  const UpcomingAppointmentsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    Get.put(UpcomingAppointmentController());
    return Scaffold(
      body: GetBuilder<UpcomingAppointmentController>(
        builder: (controller) {
          if (controller.status == AppointmentStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.status == AppointmentStatus.success) {
            if (controller.bookings.isNotEmpty) {
              return ListView.builder(
                itemCount: controller.bookings.length,
                itemBuilder: (context, index) {
                  return AppointmentCardWidget(
                    onOutlinedPressed: () {
                      showWarningDialog(
                          context: context,
                          title: 'question'.tr,
                          desc: 'desc'.tr,
                          btnCancelText: 'cancelMs'.tr,
                          btnOkText: 'ok'.tr,
                          btnOkOnPress: () {
                            controller
                                .deleteBooking(controller.bookings[index].id!);
                          });
                    },
                    onElevatedPressed: () async {
                      final result = await Get.toNamed(
                          AppRouteName.bookAppointmentPage,
                          arguments: {
                            'action': 'update',
                            'booking': controller.bookings[index]
                          });
                      if (result != null) {
                        controller.fetchUpcomingAppointments();
                      }
                    },
                    size: size,
                    color: color,
                    booking: controller.bookings[index],
                    status: "pending".tr,
                    outlinedText: "reshedule".tr,
                    buttonText: "cancel".tr,
                  );
                },
              );
            } else {
              return EmptyAppointmentsWidget(
                  size: size,
                  onPressed: () async {
                    final result = await Get.toNamed(
                        AppRouteName.bookAppointmentPage,
                        arguments: {'action': 'new'});
                    if (result != null) {
                      controller.fetchUpcomingAppointments();
                    }
                  },
                  text: " لا يوجد حجوزات قم بانشاء حجز جديد",
                  assetName: AppSvg.doctors,
                  width: 200);
            }
          }
          return Center(
            child: Text("something went wrong"),
          );
        },
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
                        AppRouteName.bookAppointmentPage,
                        arguments: {'action': 'new'});
                    if (result != null) {
                      controller.fetchUpcomingAppointments();
                    }
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
}
