
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/screens/appointment_page/past_appointment_page.dart';
import 'package:neurology_clinic/view/screens/appointment_page/upcoming_appointment_page.dart';

import '../../../controller/appointment/appointments_controller.dart';
import '../../../core/layouts/app_layout.dart';

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
        children: [
          UpcomingAppointmentsPage(),
          PastAppointmentsPage()
          
        ],
      ),
    );
  }
}
