import 'dart:convert';

import 'package:get/get.dart';
import 'package:neurology_clinic/data/datasource/model/booking_model.dart';
import 'package:http/http.dart' as http;
import 'package:neurology_clinic/services/services.dart';

enum AppointmentStatus { initial, loading, failure, success }

class PastAppointmentController extends GetxController {
  // Replace with your actual project path
  AppointmentStatus status = AppointmentStatus.initial;
  List<Booking> bookings = [];
  late MyServices myServices;

  Future<void> fetchPastAppointments() async {
    bookings.clear();
    final token = myServices.userData['token'];
    final id = myServices.userData['patient']['id'];
    final String apiUrl =
        'http://10.0.2.2:8000/api/v1/bookings?filter[status]=completed&filter[patient_id]=$id&include=doctor';
    try {
      status = AppointmentStatus.loading;
      update();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Add Bearer token
          'Accept': 'application/json', // Optional but good to specify
        },
      );
      final responseData = json.decode(response.body)['data'];
      final l = (responseData as List).map((e) => Booking.fromMap(e)).toList();

      if (response.statusCode == 200) {
        print(l);
        status = AppointmentStatus.success;
        bookings.addAll(l);
        update();
      } else {
        status = AppointmentStatus.failure;
        bookings = [];
        update();
      }
      print(status);
    } catch (e) {
      bookings = [];
    }
  }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    fetchPastAppointments();
    super.onInit();
  }
}
