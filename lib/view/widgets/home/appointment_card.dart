import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/controller/home_controller/home_controller.dart';
import '/app_theme.dart';
import '../../../core/layouts/app_color_theme.dart';
import '/data/datasource/model/booking_model.dart';

class AppointmentList extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  AppointmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingStates['bookingloading'] == true) {
        return const Center(child: CircularProgressIndicator());
      }
      // else if (controller.errorMessage.isNotEmpty) {
      //   return Center(child: Text(controller.errorMessage.value));
      // }
      else if (controller.upcomingBooking.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_busy, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text("لا توجد مواعيد قادمة"),
            ],
          ),
        );
      } else {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.upcomingBooking.length,
          itemBuilder: (context, index) {
            final Booking appointment = controller.upcomingBooking[index];
            // return
            return AppointmentCard(
              appointment: appointment,
              onCancel: () {},
              onEdit: () {},
            );
          },
        );
      }
    });
  }
}

class AppointmentCard extends StatelessWidget {
  final Booking appointment;
  final VoidCallback onCancel;
  final VoidCallback onEdit;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onCancel,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // بناء قائمة الأزرار حسب حالة الموعد
    List<Widget> actionButtons = [];
    if (appointment.status == 'unconfirmed') {
      actionButtons.add(
        actionButton(
            onPressed: onEdit,
            text: "تعديل الموعد",
            backgroundColor: AppColorTheme.background,
            textColor: AppColorTheme.shadowDark),
      );
      actionButtons.add(const Spacer());
      actionButtons.add(actionButton(
          onPressed: onCancel,
          text: "إلغاء الموعد",
          backgroundColor: AppColorTheme.background3));
    } else if (appointment.status == 'pending') {
      actionButtons.add(
        ElevatedButton(
          onPressed: onEdit,
          child: actionButton(
              onPressed: onEdit,
              text: "تعديل الموعد",
              textColor: AppColorTheme.backgroundDark),
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 380, maxHeight: 200),
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
          Text("موعدك القادم", style: themeArabic.textTheme.headlineLarge),
          const SizedBox(
            height: 15,
          ),
          Text("مع الدكتور : ${appointment.doctorName}",
              style: themeArabic.textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text("موعد زيارتك : ${appointment.date}",
              style: themeArabic.textTheme.bodyMedium),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actionButtons,
          )
        ],
      ),
    );
  }
}

Widget actionButton(
    {required void Function()? onPressed,
    Color? backgroundColor,
    Color? textColor,
    String? text}) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "$text",
          style: TextStyle(
              color: textColor, fontSize: 15, fontWeight: FontWeight.bold),
        )),
  );
}
