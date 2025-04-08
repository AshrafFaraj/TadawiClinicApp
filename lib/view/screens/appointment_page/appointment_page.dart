import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/appointments_controller.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';

import '../../../core/layouts/app_layout.dart';
import 'past_appointment_page.dart';
import 'upcoming_appointment_page.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "appo".tr, fontWeight: FontWeight.w600),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(
              text: "upc".tr,
            ),
            Tab(
              text: "pa".tr,
            )
          ],
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [UpcomingAppointmentsPage(), PastAppointmentsPage()],
      ),
      
    );
  }
}
