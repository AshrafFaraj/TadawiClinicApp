import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/services/services.dart';

import '/controller/appointment/upcoming_appointment_controller.dart';
import '/core/constants/app_route_name.dart';
import '/core/functions/dialog_functions.dart';
import '/view/widgets/appointment/Appointment_card_widget.dart';
import '../../../core/layouts/app_layout.dart';

class UpcomingAppointmentsPage extends StatelessWidget {
  UpcomingAppointmentsPage({Key? key}) : super(key: key);
  final MyServices myServices = Get.find<MyServices>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Obx(
        () {
          if (myServices.loadingStates['appointmentLoading'] == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (myServices.upcomingAppointment.isEmpty) {
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
            Get.put(UpcomingAppointmentController());
            var appointment = myServices.upcomingAppointment;
            return ListView.builder(
              itemCount: appointment.length,
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
                          myServices.deleteAppointmet(appointment[index].id);
                        });
                  },
                  onElevatedPressed: () async {
                    final result = await Get.toNamed(
                        AppRouteName.bookAppointmentPage,
                        arguments: {
                          'action': 'update',
                          'booking': appointment[index]
                        });
                    if (result != null) {
                      myServices.fetchAppointmentFromServer();
                    }
                  },
                  size: size,
                  color: color,
                  appointment: appointment[index],
                  status: "pending".tr,
                  outlinedText: "reshedule".tr,
                  buttonText: "cancel".tr,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: GetBuilder<UpcomingAppointmentController>(
        builder: (controller) {
          return Stack(
            children: [
              // Other content of the screen
              Positioned(
                bottom: 80, // Increase to move higher, decrease to move lower
                right: 16, // To adjust the horizontal position
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

class EmptyAppointmentsWidget extends StatelessWidget {
  const EmptyAppointmentsWidget({
    super.key,
    required this.size,
    required this.text,
    required this.assetName,
    required this.width,
    this.onPressed,
  });
  final Size size;
  final String text;
  final String assetName;
  final double width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .1,
          ),
          SvgPicture.asset(
            assetName,
            width: width,
          ),
          SizedBox(
            height: size.height * .09,
          ),
          textWidget(text: text, textColor: Colors.grey, fontSize: 15),
          SizedBox(height: 20),
          OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                fixedSize: Size(size.width * 0.8, size.height * .07),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Makes the button square
                ),
                side: BorderSide(
                    color: Colors.blue,
                    width: 0.9), // Customize the border color
              ),
              child: textWidget(
                  text: "bookbutton".tr,
                  textColor: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15))
        ],
      ),
    );
  }
}
