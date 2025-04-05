import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/app_theme.dart';
import 'package:neurology_clinic/view/widgets/home/doctor_card.dart';
import '../../../controller/home_controller/home_controller.dart';
import '../../widgets/home/appointment_card.dart';
import '../../widgets/home/hcard.dart';
import '../../widgets/home/custom_home_appbar.dart';
import '/core/constants/app_color.dart';
import '../../../core/layouts/app_color_theme.dart';
import '/core/constants/app_route_name.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColorTheme.background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 16),
          child: Wrap(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 992
                  ? ((MediaQuery.of(context).size.width - 20) / 2)
                  : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  CustomAppBar(controller: controller),
                  AppointmentCard(),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'قائمة الأطباء',
                      style: themeArabic.textTheme.headlineLarge,
                    ),
                  ),
                  DoctorsCard(controller: controller),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRouteName.prescription);
                        },
                        child: const HCard(
                          title: 'مراجعة الادوية',
                          color: AppColor.primaycolor,
                          icon: Icons.medical_information,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  // EmergencyButton(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
