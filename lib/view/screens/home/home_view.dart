import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app_theme.dart';
import '/view/widgets/home/doctor_card.dart';
import '../../widgets/home/appointment_card.dart';
import '../../widgets/home/hcard.dart';
import '../../widgets/home/custom_home_appbar.dart';
import '../../../core/layouts/app_color_theme.dart';
import '/core/constants/app_route_name.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: AppColorTheme.background,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAppBar(),
                  const AppointmentList(),
                  const SizedBox(height: 16),
                  const CardListTitle(title: 'قائمة الأطباء'),
                  DoctorsCard(
                    scrollDirection: Axis.horizontal,
                  ),
                  const CardListTitle(title: 'أدويتي'),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRouteName.allPrescriptions);
                        },
                        child: const HCard(
                          title: 'مراجعة الادوية',
                          color: AppColorTheme.card,
                          icon: Icons.medical_information,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRouteName.onBoarding);
                          },
                          child: Text('Test Auth'))
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

class CardListTitle extends StatelessWidget {
  const CardListTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: themeArabic.textTheme.headlineLarge,
      ),
    );
  }
}
