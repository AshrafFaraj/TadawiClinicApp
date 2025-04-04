import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/model/prescription_model.dart';

enum PrescriptionStatus { initial, loading, failure, success }

class PrescriptionsController extends GetxController {
  // Replace this with your actual Laravel API URL running on your local machine
  final String apiUrl =
      'http://10.0.2.2:8000/api/v1/prescriptions'; // Replace with your actual project path
  PrescriptionStatus status = PrescriptionStatus.initial;
  List<Prescription> prescriptions = [];

  Future<void> fetchPrescriptions() async {
    prescriptions.clear();
    try {
      status = PrescriptionStatus.loading;
      update();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer 2|Xr0QmVa8wW2BlIm3ppJWTYWiNJ5lwQZngOb3hA7Ff927d906', // Add Bearer token
          'Accept': 'application/json', // Optional but good to specify
        },
      );
      final responseData = json.decode(response.body)['data'];
      final l =
          (responseData as List).map((e) => Prescription.fromMap(e)).toList();

      if (response.statusCode == 200) {
        print(l);
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
    fetchPrescriptions();
    super.onInit();
  }
}
