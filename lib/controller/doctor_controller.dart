import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/datasource/model/doctor_model.dart';
import '../link_api.dart';
import 'connection_controller.dart';

class DoctorController extends GetxController {
  final ConnectionController _connectionController =
      Get.find<ConnectionController>();

  bool isLoading = false;
  String errorMessage = '';
  List<Doctor> doctors = [];

  @override
  void onInit() {
    super.onInit();
    // fetchDoctorsFromServer();
    // مراقبة تغير الاتصال
    ever<bool>(_connectionController.isConnected, (connected) {
      if (connected) {
        fetchDoctorsFromServer();
      }
    });
    // تحميل من الانترنت عند الاتصال
    if (_connectionController.isConnected.value) {
      fetchDoctorsFromServer();
    }
  }

  Future<void> fetchDoctorsFromServer() async {
    // print('----------------${_connectionController.isConnected.value}');
    if (!_connectionController.isConnected.value) return;
    isLoading = true;
    print('----------------Doctor Loading.....');
    update();
    try {
      final response = await http.get(
        Uri.parse(AppLink.doctorsDetails),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> doctorsJson = jsonResponse['data'];
        doctors = doctorsJson.map((json) => Doctor.fromJson(json)).toList();
        print('----------------Doctor fetched.....');
        isLoading = false;
        update();
      } else {
        errorMessage = 'لايوجد اطباء حالياً';
        isLoading = false;
        update();
      }
    } catch (e) {
      errorMessage = 'تأكد من اتصال الانترنت';
      isLoading = false;
      update();
    }
  }
}
