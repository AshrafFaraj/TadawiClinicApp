import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../widgets/home/appointment_card.dart';
import '../../widgets/home/health_tips_carousel.dart';
import '../../widgets/home/hcard.dart';
import '../../widgets/home/custom_home_appbar.dart';
import '/core/constants/app_color.dart';
import '../../../core/layouts/rive_theme.dart';
import '/core/constants/app_route_name.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: RiveAppTheme.background,
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
                  const HealthTipsCarousel(),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const HCard(
                          title: 'آخر التقارير الطبية',
                          color: AppColor.primaycolor,
                          icon: Icons.report,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRouteName.bookAppointmentPage);
                        },
                        child: const HCard(
                          title: 'إنشاء حجز جديد',
                          color: Color(0xFF005FE7),
                          icon: Icons.add_task,
                        ),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.calendar_today), label: "الحجوزات"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.description), label: "التقارير"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.chat), label: "المساعد الذكي"),
      //   ],
      // ),
    );
  }
}
