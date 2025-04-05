import 'dart:convert';
import 'package:get/get.dart';
import 'package:neurology_clinic/data/datasource/model/booking_model.dart';
import 'package:http/http.dart'as http;

import '../../data/datasource/model/prescription_model.dart';
import '../../services/services.dart';

enum PrescriptionStatus { initial, loading, failure, success }

class PrescriptionsController extends GetxController {
  // Replace this with your actual Laravel API URL running on your local machine
  // Replace with your actual project path
  PrescriptionStatus status = PrescriptionStatus.initial;
  List<Prescription> prescriptions = [];
  Booking? booking;
  late MyServices myServices;

  Future<void> fetchPrescriptions(int id) async {
    String apiUrl = 'http://10.0.2.2:8000/api/v1/prescriptions/$id';
    final token = myServices.userData['token'];
    prescriptions.clear();
    try {
      status = PrescriptionStatus.loading;
      update();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer $token', // Add Bearer token
          'Content-Type': 'application/json', // Optional but good to specify
        },
      );
      final responseData = json.decode(response.body)['data'];
      final l =
          (responseData as List).map((e) => Prescription.fromMap(e)).toList();

      if (response.statusCode == 200) {
        print(l[0].dosage);
        print("=========");
        status = PrescriptionStatus.success;
        prescriptions.addAll(l);
        update();
      } else {
        status = PrescriptionStatus.failure;
        prescriptions = [];
        update();
      }
      print(status);
    } catch (e) {
      prescriptions = [];
    }
  }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    super.onInit();
    booking = Get.arguments?['booking'] ?? Booking();

    if (booking!.id !=null) {
      fetchPrescriptions(booking!.id!);
    }
  }
}
