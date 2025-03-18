import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/home_controller.dart';
import '/core/layouts/rive_theme.dart';

class CustomAppBar extends StatelessWidget {
  final HomeController controller;
  const CustomAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications,
                  size: 30,
                ),
                Positioned(
                  right: 0,
                  child: Obx(() => controller.unreadNotifications.value > 0
                      ? CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.red,
                          child: Text(
                            "${controller.unreadNotifications.value}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        )
                      : const SizedBox()),
                ),
              ],
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          Obx(() => Text(
                "مرحبًا, ${controller.patient.value.name}",
                style: const TextStyle(
                    fontSize: 20,
                    color: RiveAppTheme.shadowDark,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
