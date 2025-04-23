import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';
import '../../../controller/home_controller/home_controller.dart';
import '../../../core/layouts/app_color_theme.dart';
import '../../../services/services.dart';

class CustomAppBar extends StatelessWidget {
  final MyServices myServices = Get.find<MyServices>();
  CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 15),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications,
                  size: 35,
                ),
                Positioned(
                  right: 0,
                  child: GetBuilder<HomeController>(
                      builder: (controller) =>
                          controller.unreadNotifications > 0
                              ? CircleAvatar(
                                  radius: 10.5,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    "${controller.unreadNotifications}",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                )
                              : const SizedBox()),
                ),
              ],
            ),
            onPressed: () {
              Get.toNamed(AppRouteName.notificationsPage);
            },
          ),
          GetBuilder<HomeController>(
              builder: (controller) => Text(
                    "مرحبًا, ${myServices.userData['user']['name'] ?? ''}",
                    style: const TextStyle(
                        fontSize: 17,
                        color: AppColorTheme.shadowDark,
                        fontWeight: FontWeight.bold),
                  )),
        ],
      ),
    );
  }
}
