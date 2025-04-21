import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/model/appointment_model.dart';
import '/link_api.dart';
import '/services/services.dart';
import '../../core/layouts/app_color_theme.dart';
import '../connection_controller.dart';

enum AppointmentStatus { initial, loading, failure, success }

class PastAppointmentController extends GetxController {
  AppointmentStatus status = AppointmentStatus.initial;

  // خاص بمراقبة الانترنت
  final ConnectionController _connectionController =
      Get.find<ConnectionController>();

  late MyServices _myServices;
  late String _token;

  bool isLoading = false;
  String errorMessage = '';

  static const String _pastKey = 'pastAppointment';
  List<Appointment> pastAppointments = [];

  // @override
  // void onInit() {

  //   _myServices = Get.find<MyServices>();
  //   _token = _myServices.userData['token'];

  //   pastAppointments = fetchPastAppointmentFromCach(_pastKey);
  //   update();
  //   // مراقبة التغيير في الاتصال
  //   ever<bool>(_connectionController.isConnected, (connected) {
  //     if (connected) {
  //       fetchPastAppointmentFromServer();
  //     }
  //   });

  //   // تحميل من الانترنت عند الاتصال
  //   fetchPastAppointmentFromServer();
  //   super.onInit();
  // }
  initial() {
    _myServices = Get.find<MyServices>();
    _token = _myServices.userData['token'];
    print(_token);
    pastAppointments.clear();
    pastAppointments = fetchPastAppointmentFromCach(_pastKey);
    update();
    // مراقبة التغيير في الاتصال
    ever<bool>(_connectionController.isConnected, (connected) {
      if (connected) {
        fetchPastAppointmentFromServer();
      }
    });

    // تحميل من الانترنت عند الاتصال
    fetchPastAppointmentFromServer();
  }

  Future<void> fetchPastAppointmentFromServer() async {
    if (!_connectionController.isConnected.value) return;
    isLoading = true;
    print("fetchiiing");
    update();
    try {
      final response = await http.get(
        Uri.parse(AppLink.pastAppointments),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $_token",
          'Accept': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> appointmentsJson = jsonResponse['data'] ?? [];
        pastAppointments.clear();
        pastAppointments =
            appointmentsJson.map((json) => Appointment.fromJson(json)).toList();

        update();
        if (pastAppointments.isNotEmpty) {
          await _myServices.storeData(
              _pastKey, pastAppointments.map((b) => b.toJson()).toList());
        }
      } else {
        Get.snackbar('فشل', 'لم نتمكن حاليا من تحديث مواعيدك السابقة',
            backgroundColor: AppColorTheme.background3);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'تحقق من اتصالك بالإنترنت',
          backgroundColor: AppColorTheme.background3);
      print(e);
    }
    isLoading = false;
    update();
  }

  List<Appointment> fetchPastAppointmentFromCach(String key) {
    final cachedData = _myServices.getData(key);
    List<dynamic> dataList = [];

    if (cachedData != null) {
      if (cachedData is List) {
        dataList = cachedData;
      } else if (cachedData is Map) {
        dataList = cachedData.values.toList();
      }
      return dataList
          .map((json) => Appointment.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } else {
      return [];
    }
  }
}
