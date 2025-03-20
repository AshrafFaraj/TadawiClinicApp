import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/upcoming_appointment_controller.dart';
import 'package:neurology_clinic/view/widgets/appointment/Appointment_card_widget.dart';
import '../../../core/layouts/app_layout.dart';

class UpcomingAppointmentsPage extends StatelessWidget {
  const UpcomingAppointmentsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    Get.put(UpcomingAppointmentController());
    return GetBuilder<UpcomingAppointmentController>(
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
              return AppointmentCardWidget(
                  size: size,
                  color: color,
                  booking: controller.bookings[index]);
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
