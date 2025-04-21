import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/book_appointment/book_appointment_controller.dart';
import 'package:neurology_clinic/core/layouts/app_color_theme.dart';

import '../../../../core/layouts/app_layout.dart';

class SimpleUseExample extends StatelessWidget {
  const SimpleUseExample({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    Get.put(BookAppointmentController());
    return GetBuilder<BookAppointmentController>(
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "selectdate".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            EasyDateTimeLinePicker(
              controller: controller.dateController,
              firstDate: DateTime.now(),
              lastDate: DateTime(2026, 3, 18),
              locale: Get.locale,
              // locale: controller.initialLang,
              focusedDate: controller.selectedDate,
              onDateChange: (selectedDate) {
                controller.onDateChange(selectedDate);
              },
            ),
            SizedBox(height: 20),
            Text(
              "selecttime".tr,
              style: TextStyle(
                  fontSize: 18,
                  color: AppColorTheme.shadowDark,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            controller.timeSlots.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "الطبيب لا يداوم في هاذا اليوم",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: controller.timeSlots.map((time) {
                            return ElevatedButton(
                                onPressed: () {
                                  controller.changeTime(time);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(101, 15),
                                  backgroundColor:
                                      controller.selectedTime == time
                                          ? color.primary
                                          : Colors.white,
                                  side: BorderSide(
                                    color: controller.selectedTime == time
                                        ? color.primary
                                        : Colors.grey,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: controller.selectedTime == time
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: controller.selectedTime != null
                    ? () {
                        if (controller.action == "update") {
                          controller.updateBooking();
                        } else {
                          controller.bookAppointment();
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: color.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Makes the button square
                  ),
                ),
                child: controller.status == BookAppointmentStatus.loading
                    ? CircularProgressIndicator()
                    : textWidget(
                        text: controller.action == "new"
                            ? "setappointment".tr
                            : "Update",
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
