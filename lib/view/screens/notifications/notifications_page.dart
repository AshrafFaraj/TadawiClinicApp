import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/notifications/notifications_controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          if (controller.notificationsList.isEmpty) {
            return Center(
              child: Text(
                "Empty",
                style: TextStyle(color: Colors.black),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.notificationsList.length,
            itemBuilder: (_, index) {
              final n = controller.notificationsList[index];
              return ListTile(
                title: Text(
                  n.title,
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(n.body),
                // trailing: Text(
                //   '${n.receivedAt.hour}:${n.receivedAt.minute.toString().padLeft(2, '0')}',
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
