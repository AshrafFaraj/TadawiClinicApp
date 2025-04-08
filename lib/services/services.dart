import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../data/datasource/model/booking_model.dart';
import '../data/datasource/model/doctor_model.dart';
import '../link_api.dart';

class MyServices extends GetxService {
  late Box _box;
  var loadingStates = <String, bool>{}.obs;

  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  static const String _upcomingKey = 'upcomingAppointment';
  static const String _pastKey = 'pastAppointment';
  var upcomingAppointment = <Appointment>[].obs;
  var pastAppointment = <Appointment>[].obs;

  var errorMessage = ''.obs;
  DateTime? lastAppointmentFetched;
  static const cacheAppointmentDuration = Duration(minutes: 1);

  // توقيت آخر جلب للبيانات
  static const cacheDoctorDuration = Duration(minutes: 1);
  DateTime? lastDoctorFetched;
  var doctors = <Doctor>[].obs;

  Future<MyServices> init() async {
    _box = await Hive.openBox('appBox');
    userData.value = Map<String, dynamic>.from(getData('userData'));
    await fetchDoctors();
    upcomingAppointment.value = fetchAppointmentFromCach(_upcomingKey);
    pastAppointment.value = fetchAppointmentFromCach(_pastKey);
    await fetchAppointmentFromServer();

    return this;
  }

  // دالة عامة لتخزين البيانات بأي مفتاح
  Future<void> storeData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  // دالة عامة لاسترجاع البيانات بأي مفتاح
  dynamic getData(String key) {
    if (_box.containsKey(key)) {
      return _box.get(key);
    }
    return <String, dynamic>{};
  }

  // دالة عامة لحذف بيانات بواسطة المفتاح
  Future<void> clearData(String key) async {
    await _box.delete(key);
  }

  // دالة لجلب بيانات الأطباء من API مع استخدام Caching
  Future<void> fetchDoctors({bool forceRefresh = false}) async {
    const key = 'doctorLoading';
    try {
      loadingStates[key] = true;
      final response = await http.get(
        Uri.parse(AppLink.doctorsDetails),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // print('doctors ${jsonResponse}');
        // data بيانات الأطباء موجودة تحت مفتاح ''
        final List<dynamic> doctorsJson = jsonResponse['data'];
        doctors.value =
            doctorsJson.map((json) => Doctor.fromJson(json)).toList();
        // تحديث توقيت الجلب بعد النجاح
        lastDoctorFetched = DateTime.now();
      } else {
        errorMessage.value = 'Failed to load doctors';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      loadingStates[key] = false;
    }
  }

  /// جلب البيانات من الـ API وتحديث الكاش
  Future<void> fetchAppointmentFromServer() async {
    const key = 'appointmentLoading';
    try {
      loadingStates[key] = true;
      final response = await http.get(
        Uri.parse(AppLink.getBookings),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer ${userData['token']}", // ضع التوكن المناسب هنا
          'Accept': 'application/json',
        },
      );
      // print('---------------------- ---${userData['token']}');
      print('----------------------------${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // افترض أن البيانات موجودة تحت مفتاح 'data' وهي قائمة من الحجوزات
        final List<dynamic> appointmentsJson = jsonResponse['data'] ?? [];
        final List<Appointment> appointmentsList =
            appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
        // print(appointmentsList);
        upcomingAppointment.clear();
        pastAppointment.clear();
        upcomingAppointment.value = appointmentsList
            .where((appointment) =>
                appointment.status == 'unconfirmed' ||
                appointment.status == 'pending')
            .toList();
        pastAppointment.value = appointmentsList
            .where((appointment) => appointment.status == 'completed')
            .toList();

        // print(upcomingAppointment);

        if (appointmentsList.isNotEmpty) {
          // تخزين البيانات الخام في الكاش
          await storeData(_upcomingKey,
              upcomingAppointment.map((b) => b.toJson()).toList());
          await storeData(
              _pastKey, pastAppointment.map((b) => b.toJson()).toList());
        }
      } else {
        errorMessage.value =
            'Failed to load Appointments: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      loadingStates[key] = false;
    }
  }

  Future<void> deleteAppointmet(int bookingId) async {
    try {
      // Replace with the actual URL of your API endpoint
      final url = Uri.parse('http://10.0.2.2:8000/api/v1/bookings/$bookingId');

      final response = await http.delete(
        url,
        headers: {
          'Authorization':
              'Bearer ${userData['token']}', // Replace with actual token
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Booking deleted successfully
        Get.snackbar('Success', 'Booking deleted successfully');
        clearData(_upcomingKey);
        await fetchAppointmentFromServer();
        fetchAppointmentFromCach(_upcomingKey);
      } else {
        // Failed to delete booking
        Get.snackbar('Error', 'Failed to delete booking');
      }
      print(response.body);
    } catch (e) {
      // Handle error (e.g., no network connection)
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  List<Appointment> fetchAppointmentFromCach(String key) {
    final cachedData = getData(key);
    List<dynamic> dataList = [];

    if (cachedData != null) {
      if (cachedData is List) {
        dataList = cachedData;
      } else if (cachedData is Map) {
        // إذا كانت البيانات مخزنة كـ Map، نستخدم قيمها
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

initialServices() async {
  await Get.putAsync<MyServices>(() => MyServices().init());
}
