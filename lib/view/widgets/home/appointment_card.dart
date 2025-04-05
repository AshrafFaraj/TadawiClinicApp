import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller/home_controller.dart';
import '../../../core/layouts/app_color_theme.dart';

class AppointmentCard extends StatelessWidget {
  final HomeController controller = Get.find();

  AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 260),
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColorTheme.card,
              AppColorTheme.card.withValues(alpha: 0.5)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                color: AppColorTheme.card.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: AppColorTheme.card.withValues(alpha: 0.3),
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("موعدك القادم",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("الدكتور: ${controller.nextAppointment['doctor']}"),
              Text("التاريخ: ${controller.nextAppointment['date']}"),
              Text("الوقت: ${controller.nextAppointment['time']}"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text("تعديل الموعد",
                          style: TextStyle(
                              color: AppColorTheme.background2, fontSize: 18))),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "إلغاء",
                        style: TextStyle(
                            color: AppColorTheme.background2, fontSize: 18),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
