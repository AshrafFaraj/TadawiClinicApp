import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/data/datasource/model/booking_model.dart';
import '../../data/datasource/model/prescription_model.dart';
import '../../services/services.dart';

enum AllPrescriptionsStatus { initial, loading, failure, success }

class AllPrescriptionsController extends GetxController {
  // Replace this with your actual Laravel API URL running on your local machine
  // Replace with your actual project path
  AllPrescriptionsStatus status = AllPrescriptionsStatus.initial;
  List<Prescription> prescriptions = [];
  Appointment? appointment;
  late MyServices myServices;

  Future<void> fetchPrescriptions(int id) async {
    String apiUrl = 'http://10.0.2.2:8000/api/v1/prescriptions/$id';
    final token = myServices.userData['token'];
    prescriptions.clear();
    try {
      status = AllPrescriptionsStatus.loading;
      update();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Add Bearer token
          'Content-Type': 'application/json', // Optional but good to specify
        },
      );
      final responseData = json.decode(response.body)['data'];
      final l =
          (responseData as List).map((e) => Prescription.fromMap(e)).toList();

      if (response.statusCode == 200) {
        print(l[0].dosage);
        print("=========");
        status = AllPrescriptionsStatus.success;
        prescriptions.addAll(l);
        update();
      } else {
        status = AllPrescriptionsStatus.failure;
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
    appointment = Get.arguments?['booking'];

    if (appointment!.id != null) {
      fetchPrescriptions(appointment!.id);
    }
  }
}
