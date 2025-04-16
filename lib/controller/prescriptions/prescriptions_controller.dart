import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../connection_controller.dart';
import '/data/datasource/model/booking_model.dart';
import '../../data/datasource/model/prescription_model.dart';
import '../../services/services.dart';

enum PrescriptionStatus { initial, loading, failure, success }

class PrescriptionsController extends GetxController {
  // Replace this with your actual Laravel API URL running on your local machine
  // Replace with your actual project path
  PrescriptionStatus status = PrescriptionStatus.initial;
  List<Prescription> prescriptions = [];
  Appointment? appointment;
  late MyServices myServices;
  final ConnectionController _connectionController =
      Get.find<ConnectionController>();
  String _token = "";

  Future<void> fetchPrescriptions(int id) async {
    // String apiUrl = 'http://10.0.2.2:8000/api/v1/prescriptions/$id';
    String apiUrl = 'http://192.168.57.234/api/v1/prescriptions/$id';
    prescriptions.clear();
    if (!_connectionController.isConnected.value) return;
    status = PrescriptionStatus.loading;
    update();
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $_token', // Add Bearer token
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
    _token = myServices.userData['token'];
    super.onInit();
    appointment = Get.arguments?['booking'];
    ever<bool>(_connectionController.isConnected, (connected) {
      if (connected) {
        fetchPrescriptions(appointment!.id);
      }
    });

    // تحميل من الانترنت عند الاتصال
    fetchPrescriptions(appointment!.id);
  }
}
