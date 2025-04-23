import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/app_route_name.dart';
import '../../../core/functions/dialog_functions.dart';
import '../../../data/datasource/model/appointment_model.dart';
import '/controller/appointment/upcoming_appointment_controller.dart';
import '/app_theme.dart';
import '../../../core/layouts/app_color_theme.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<UpcomingAppointmentController>().initial();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 200,
      child: GetBuilder<UpcomingAppointmentController>(builder: (controller) {
        return Skeletonizer(
            enabled: controller.isLoading,
            child: (controller.upcomingAppointments.isEmpty)
                ? Center(
                    child: Container(
                      constraints:
                          const BoxConstraints(maxWidth: 360, maxHeight: 200),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColorTheme.card,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.event_busy,
                              size: 80, color: AppColorTheme.background),
                          const SizedBox(height: 16),
                          Text("لا توجد مواعيد قادمة",
                              style: themeArabic.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.upcomingAppointments.length,
                    itemBuilder: (context, index) {
                      final Appointment appointment =
                          controller.upcomingAppointments[index];
                      // return
                      return AppointmentCard(
                        appointment: appointment,
                        onCancel: () {
                          showWarningDialog(
                              context: context,
                              title: 'question'.tr,
                              desc: 'desc'.tr,
                              btnCancelText: 'cancelMs'.tr,
                              btnOkText: 'ok'.tr,
                              btnOkOnPress: () {
                                controller.deleteAppointmet(appointment.id);
                              });
                        },
                        onEdit: () async {
                          final result = await Get.toNamed(
                              AppRouteName.bookAppointmentPage,
                              arguments: {
                                'action': 'update',
                                'booking': appointment
                              });
                          if (result != null) {
                            controller.fetchUpcomingAppointmentFromServer();
                          }
                        },
                      );
                    }));
      }),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
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
    return Container(
      constraints: const BoxConstraints(maxWidth: 360, maxHeight: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColorTheme.card.withValues(alpha: 0.9),
          AppColorTheme.card.withValues(alpha: 0.3)
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
            height: 10,
          ),
          Center(
            child: Text("مع الدكتور : ${appointment.doctorName}",
                style: themeArabic.textTheme.bodyMedium),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            constraints: const BoxConstraints(minHeight: 40),
            decoration: BoxDecoration(
                color: AppColorTheme.card,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                Text(" ${appointment.date}",
                    style: themeArabic.textTheme.bodyMedium),
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  'assets/clock.png',
                  color: Colors.white,
                ),
                Text("  ${appointment.time.hour}:${appointment.time.minute}",
                    style: themeArabic.textTheme.bodyMedium),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          appointment.type == 'new'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (appointment.status == 'unconfirmed')
                        ? actionButton(
                            onPressed: onCancel,
                            text: "إلغاء الموعد",
                          )
                        : const SizedBox(),
                    const Spacer(),
                    actionButton(
                        onPressed: onEdit,
                        text: "تعديل الموعد",
                        backgroundColor: AppColorTheme.background,
                        textColor: AppColorTheme.shadowDark),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

Widget actionButton(
    {required void Function()? onPressed,
    Color? backgroundColor = AppColorTheme.background3,
    Color? textColor,
    String? text}) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          "$text",
          style: TextStyle(
              color: textColor, fontSize: 15, fontWeight: FontWeight.bold),
        )),
  );
}
