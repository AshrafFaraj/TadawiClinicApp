import 'dart:convert';

import 'package:get/get.dart';
import 'package:neurology_clinic/data/datasource/model/booking_model.dart';
import 'package:http/http.dart' as http;
enum AppointmentStatus { initial, loading, failure, success }
class UpcomingAppointmentController extends GetxController{
  final String apiUrl =
      'http://10.0.2.2:8000/api/v1/bookings?filter[status]=pending&filter[patient_id]=1&include=doctor'; // Replace with your actual project path
  AppointmentStatus status = AppointmentStatus.initial;
  List<Booking> bookings = [];

  Future<void> fetchUpcomingAppointments() async {
    bookings.clear();
    try {
      status = AppointmentStatus.loading;
      update();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer 1|Snn8NkpgVRBlTFIZzKI4MGiL4KY2PSa3XNsL2EYmea684a90', // Add Bearer token
          'Accept': 'application/json', // Optional but good to specify
        },
      );
      final responseData = json.decode(response.body)['data'];
      final l =
          (responseData as List).map((e) => Booking.fromMap(e)).toList();

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
    fetchUpcomingAppointments();
    super.onInit();
  }
}


