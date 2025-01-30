import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/layouts/app_layout.dart';
import '../../../locale/local_controller.dart';

class SimpleUseExample extends StatefulWidget {
  const SimpleUseExample({super.key});

  @override
  State<SimpleUseExample> createState() => _NewWidgetExampleState();
}

class _NewWidgetExampleState extends State<SimpleUseExample> {
  final _now = DateTime.now();
  DateTime _selectedDate = DateTime(2024, 3, 18);
  late final EasyDatePickerController _controller;
  String? _selectedTime;
  final List<String> _timeSlots = [
    "8:00 AM",
    "8:30 AM",
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 AM",
    "12:30 AM",
    "1:00 AM",
    "1:30 AM"
  ];

  @override
  void initState() {
    super.initState();
    _controller = EasyDatePickerController();
  }

  @override
  void dispose() {
    // do not forget to dispose the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
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
            controller: _controller,
            firstDate: DateTime(2024, 3, 18),
            lastDate: DateTime(2030, 3, 18),
            locale: Get.locale,
            // locale: controller.initialLang,
            focusedDate: _selectedDate,
            onDateChange: (selectedDate) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            "selecttime".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _timeSlots.map((time) {
                  return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(101, 15),
                        backgroundColor: _selectedTime == time
                            ? color.primary
                            : Colors.white,
                        side: BorderSide(
                          color: _selectedTime == time
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
                          color: _selectedTime == time
                              ? Colors.white
                              : Colors.black,
                        ),
                      ));
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _selectedTime != null
                ? () {
                    // Handle booking logic
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Appointment booked on $_selectedDate at $_selectedTime",
                      ),
                    ));
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
            child: textWidget(
                text: "setappointment".tr,
                textColor: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
