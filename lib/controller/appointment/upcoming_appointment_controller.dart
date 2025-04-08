import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:neurology_clinic/data/datasource/model/booking_model.dart';

import '../../services/services.dart';

enum AppointmentStatus { initial, loading, failure, success }

class UpcomingAppointmentController extends GetxController {
  // Replace with your actual project path
  AppointmentStatus status = AppointmentStatus.initial;
  List<Booking> bookings = [];
  late MyServices myServices;
  String? token;
  int id = 0;

  Future<void> fetchUpcomingAppointments() async {
    final String apiUrl =
        'http://10.0.2.2:8000/api/v1/bookings?filter[status]=pending&filter[patient_id]=$id&include=doctor';
    bookings.clear();
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
      print(response.body);
      final responseData = json.decode(response.body)['data'];
      final l = (responseData as List).map((e) => Booking.fromMap(e)).toList();

      if (response.statusCode == 200) {
        print(l[0].doctor!.name);
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

  // Future<void> deleteBooking(int bookingId) async {
  //   try {
  //     // Replace with the actual URL of your API endpoint
  //     final url = Uri.parse('http://10.0.2.2:8000/api/v1/bookings/$bookingId');

  //     final response = await http.delete(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token', // Replace with actual token
  //         'Accept': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // Booking deleted successfully
  //       Get.snackbar('Success', 'Booking deleted successfully');
  //       fetchUpcomingAppointments();
  //     } else {
  //       // Failed to delete booking
  //       Get.snackbar('Error', 'Failed to delete booking');
  //     }
  //     print(response.body);
  //   } catch (e) {
  //     // Handle error (e.g., no network connection)
  //     Get.snackbar('Error', 'Something went wrong. Please try again.');
  //   }
  // }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    token = myServices.userData['token'];
    id = myServices.userData['patient']['id'];

    super.onInit();
  }
}
