import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  final now = DateTime.now();
  DateTime selectedDate = DateTime(2024, 3, 18);
  late final EasyDatePickerController dateController;
  String? selectedTime;
  final List<String> timeSlots = [
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
  onDateChange(DateTime selectDates) {
    selectedDate = selectDates;
    update();
  }

  changeTime(String time) {
    selectedTime = time;
    update();
  }

  @override
  void onInit() {
    dateController = EasyDatePickerController();
    super.onInit();
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}
