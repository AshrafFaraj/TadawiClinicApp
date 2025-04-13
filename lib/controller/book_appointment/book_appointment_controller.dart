import 'dart:convert';

import 'package:easy_date_timeline/easy_date_timeline.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:neurology_clinic/data/datasource/model/booking_model.dart';
import 'package:neurology_clinic/data/datasource/model/doctor_shedule_model.dart';

import '../../core/functions/dialog_functions.dart';
import '../../services/services.dart';

enum BookAppointmentStatus {
  initial,
  loading,
  failure,
  success,
  timeLoading,
  timeSuccess,
  timeFailure
}

class BookAppointmentController extends GetxController {
  final now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  late final EasyDatePickerController dateController;
  String? selectedTime;
  String? formattedTime;
  BookAppointmentStatus status = BookAppointmentStatus.initial;
  String action = "";
  Booking? exsexistingBooking;
  List<String> timeSlots = [];
  late MyServices myServices;
  String? token;
  int id = 0;

  generateTimeSlots(String startTime, String endTime) {
    final DateFormat formatter = DateFormat('hh:mm a'); // For output formatting
    // Convert the start and end times from String to DateTime objects
    DateTime start = DateFormat("HH:mm:ss").parse(
        startTime); // Use 24-hour format if the API returns time like '10:00:00'
    DateTime end = DateFormat("HH:mm:ss").parse(endTime);

    List<String> slots = [];

    // Generate time slots
    while (start.isBefore(end)) {
      slots.add(formatter.format(
          start)); // Format the DateTime object back to a string in 'hh:mm a' format
      start = start.add(const Duration(minutes: 30)); // Increment by 30 minutes
    }

    timeSlots = slots; // Store the generated slots
  }

  // int doctorId=0;
  Future<void> getAvailableTimes(DateTime selectedDate) async {
    try {
      status = BookAppointmentStatus.timeLoading;
      update();
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:8000/api/v1/doctors/1/schedule?date=${selectedDate.toIso8601String()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final responseData = json.decode(response.body)['data'];
      final l =
          (responseData as List).map((e) => DoctorShedule.fromMap(e)).toList();

      if (response.statusCode == 200) {
        generateTimeSlots(l[0].startTime!, l[0].endTime!);
        status = BookAppointmentStatus.timeSuccess;
        update();
      } else {
        status = BookAppointmentStatus.timeFailure;
        update();
        Get.snackbar('Error', 'Failed to fetch available time slots');
      }
    } catch (e) {
      status = BookAppointmentStatus.timeFailure;
      update();
    }
  }

  onDateChange(DateTime selectDates) {
    selectedDate = selectDates;
    getAvailableTimes(
        selectDates); // Fetch the available times for the selected date
    update();
  }

  Future<void> bookAppointment() async {
    try {
      status = BookAppointmentStatus.loading;
      update();
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Replace with your auth token
          'Accept': 'application/json',
        },
        body: json.encode({
          'patient_id': id,
          'doctor_id': 1,
          'date': selectedDate.toIso8601String(),
          'time': formattedTime,
          'type': 'new', // Default type is 'general'
          'status': 'pending', // Default status is 'pending'
          'is_paid': 0,
        }),
      );

      if (response.statusCode == 201) {
        showSuccessDialog(
          context: Get.context!,
          btnOkText: "ok".tr,
          title: 'succes'.tr,
          desc: 'opDone'.tr,
          btnOkOnPress: () {
            Get.back(result: "success");
          },
        );
        status = BookAppointmentStatus.success;
        update();

        // Get.snackbar('Success', 'Booking created successfully');
        // Get.back(result: 'success');
      } else if (response.statusCode == 400) {
        // Handle the case when the patient already has a booking on the same date
        showErrorDialog(
          context: Get.context!,
          title: 'error'.tr,
          desc: "errorDesc".tr,
          btnOkText: "ok".tr,
        );
        status = BookAppointmentStatus.failure;
        update();
      } else {
        // Handle error
        status = BookAppointmentStatus.failure;
        Get.snackbar('Error', 'Failed to create booking');
      }
      print(response.body);
    } catch (e) {
      // Handle network errors
      status = BookAppointmentStatus.failure;
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  Future<void> updateBooking() async {
    try {
      status = BookAppointmentStatus.loading;
      update();

      final response = await http.patch(
        Uri.parse(
            'http://10.0.2.2:8000/api/v1/bookings/${exsexistingBooking!.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Replace with your auth token
          'Accept': 'application/json',
        },
        body: json.encode({
          'patient_id': id,
          'doctor_id': 1,
          'date': selectedDate.toIso8601String(),
          'time': formattedTime,
          'type': 'new', // Default type is 'general'
          'status': 'pending', // Default status is 'pending'
          'is_paid': 0,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Successfully created booking
        showSuccessDialog(
          context: Get.context!,
          btnOkText: "ok".tr,
          title: 'succes'.tr,
          desc: 'opDone'.tr,
          btnOkOnPress: () {
            Get.back(result: "success");
          },
        );
        status = BookAppointmentStatus.success;
        update();
        // Get.snackbar('Success', 'Booking created successfully');
        // Get.back(result: 'success');
      } else if (response.statusCode == 400) {
        // Handle the case when the patient already has a booking on the same date
        showErrorDialog(
          context: Get.context!,
          title: 'error'.tr,
          desc: "errorDesc".tr,
        );
        status = BookAppointmentStatus.failure;
        update();
      } else {
        // Handle error
        status = BookAppointmentStatus.failure;
        Get.snackbar('Error', 'Failed to create booking');
      }
      print(response.body);
    } catch (e) {
      // Handle network errors
      print(e);
      status = BookAppointmentStatus.failure;
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  check() {
    print(formattedTime);
  }

  formatTime(String? time) {
    final parsedTime = DateFormat('hh:mm a').parse(time!);

    formattedTime = DateFormat('H:mm').format(parsedTime);
  }

  changeTime(String time) {
    selectedTime = time;
    update();
    formatTime(selectedTime);
  }

  @override
  void onInit() {
    print(Get.arguments['action']);
    myServices = Get.find<MyServices>();
    token = myServices.userData['token'];
    id = myServices.userData['patient']['id'];

    getAvailableTimes(DateTime.now());
    // doctorId = Get.arguments?['doctorId'] ?? 0;
    dateController = EasyDatePickerController();
    action = Get.arguments?['action'] ?? "";
    exsexistingBooking = Get.arguments?['booking'];
    if (action == "update" && exsexistingBooking != null) {
      selectedDate = DateTime.parse(exsexistingBooking!.date!);
    }
    super.onInit();
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}
