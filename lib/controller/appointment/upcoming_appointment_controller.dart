import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/layouts/app_color_theme.dart';
import '../../data/datasource/model/appointment_model.dart';
import '../../link_api.dart';
import '../connection_controller.dart';
import '../../services/services.dart';

enum AppointmentStatus { initial, loading, failure, success }

class UpcomingAppointmentController extends GetxController {
  // Replace with your actual project path
  AppointmentStatus status = AppointmentStatus.initial;

  final ConnectionController _connectionController =
      Get.find<ConnectionController>();
  late MyServices _myServices;
  late String _token;

  bool isLoading = false;
  String errorMessage = '';

  static const String _upcomingKey = 'upcomingAppointment';
  List<Appointment> upcomingAppointments = [];

  // @override
  // void onInit() {
  //   _myServices = Get.find<MyServices>();
  //   _token = _myServices.userData['token'];
  //   upcomingAppointments = fetchUpcomingAppointmentFromCach(_upcomingKey);
  //   update();
  //   // مراقبة التغيير في الاتصال
  //   ever<bool>(_connectionController.isConnected, (connected) {
  //     if (connected) {
  //       fetchUpcomingAppointmentFromServer();
  //     }
  //   });

  //   // تحميل من الانترنت عند الاتصال
  //   fetchUpcomingAppointmentFromServer();

  //   super.onInit();
  // }
  initial() {
    _myServices = Get.find<MyServices>();
    _token = _myServices.userData['token'];
    checkConnectionFetching();
  }

  Future<void> checkConnectionFetching() async {
    upcomingAppointments = fetchUpcomingAppointmentFromCach(_upcomingKey);
    update();
    // مراقبة التغيير في الاتصال
    ever<bool>(_connectionController.isConnected, (connected) {
      if (connected) {
        fetchUpcomingAppointmentFromServer();
      }
    });

    // تحميل من الانترنت عند الاتصال
    fetchUpcomingAppointmentFromServer();
  }

  Future<void> fetchUpcomingAppointmentFromServer() async {
    if (!_connectionController.isConnected.value) return;
    isLoading = true;
    update();
    try {
      final response = await http.get(
        Uri.parse(AppLink.upcomingAppointments),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $_token",
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> appointmentsJson = jsonResponse['data'] ?? [];
        upcomingAppointments.clear();
        upcomingAppointments =
            appointmentsJson.map((json) => Appointment.fromJson(json)).toList();

        update();

        if (upcomingAppointments.isNotEmpty) {
          await _myServices.storeData(_upcomingKey,
              upcomingAppointments.map((b) => b.toJson()).toList());
        }
      } else {
        Get.snackbar('فشل', 'لم نتمكن حاليا من تحديث مواعيدك القادمة',
            backgroundColor: AppColorTheme.background3);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'تحقق من اتصالك بالإنترنت',
          backgroundColor: AppColorTheme.background3);
    }
    isLoading = false;
    update();
  }

  Future<void> deleteAppointmet(int bookingId) async {
    try {
      final url = Uri.parse('${AppLink.deleteAppointment}$bookingId');
      print('************************${AppLink.deleteAppointment}$bookingId');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        upcomingAppointments
            .removeWhere((appointment) => appointment.id == bookingId);
        update();
        Get.snackbar('نجاح', 'تم حذف الموعد بنجاح');
        await fetchUpcomingAppointmentFromServer();
      } else {
        Get.snackbar('خطأ', 'فشلت عملية حذف الموعد',
            backgroundColor: AppColorTheme.background3);
      }
    } catch (e) {
      Get.snackbar('فشل', 'حاول مرة اخرى',
          backgroundColor: AppColorTheme.background3);
    }
  }

  List<Appointment> fetchUpcomingAppointmentFromCach(String key) {
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
