import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../data/datasource/model/booking_model.dart';
import '../../data/datasource/model/doctor_model.dart';
import '../../link_api.dart';
import '../../services/services.dart';

class HomeController extends GetxController {
  final MyServices myServices = Get.find<MyServices>();

  var loadingStates = <String, bool>{}.obs;
  var doctors = <Doctor>[].obs;

  var upcomingBooking = <Booking>[].obs;
  var errorMessage = ''.obs;

  // توقيت آخر جلب للبيانات
  DateTime? lastFetched;
  DateTime? lastBookingFetched;
  // مدة صلاحية التخزين المؤقت (10 دقائق)
  static const cacheDuration = Duration(minutes: 10);
  static const cacheBookingDuration = Duration(minutes: 1);

  // دالة لجلب بيانات الأطباء من API مع استخدام Caching
  Future<void> fetchDoctors({bool forceRefresh = false}) async {
    const key = 'doctorloading';

    // التحقق من وجود بيانات مخزنة وأنها لم تنتهِ صلاحيتها
    if (!forceRefresh && lastFetched != null) {
      final difference = DateTime.now().difference(lastFetched!);
      if (difference < cacheDuration) {
        // البيانات ما زالت صالحة، فلا حاجة لإعادة الطلب
        return;
      }
    }
    try {
      loadingStates[key] = true;
      final response = await http.get(
        Uri.parse(AppLink.doctorsDetails),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // data بيانات الأطباء موجودة تحت مفتاح ''
        final List<dynamic> doctorsJson = jsonResponse['data'];
        doctors.value =
            doctorsJson.map((json) => Doctor.fromJson(json)).toList();
        // تحديث توقيت الجلب بعد النجاح
        lastFetched = DateTime.now();
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
  Future<void> fetchLatestBookingFromServer() async {
    const key = 'bookingloading';
    loadingStates[key] = true;
    // تحقق من انتهاء صلاحية الكاش أو forceRefresh إذا أردت التحديث
    if (lastBookingFetched != null &&
        DateTime.now().difference(lastBookingFetched!) < cacheBookingDuration) {
      // البيانات لا تزال صالحة؛ نحدثها في الخلفية
      return;
    }

    try {
      loadingStates[key] = true;
      final response = await http.get(
        Uri.parse(AppLink.upcomingBookings),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer ${myServices.userData['token']}", // ضع التوكن المناسب هنا
          'Accept': 'application/json',
        },
      );
      print('---------------------- ---${myServices.userData['token']}');
      print(
          '---------------------------------------------------${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // افترض أن البيانات موجودة تحت مفتاح 'data' وهي قائمة من الحجوزات
        final List<dynamic> upcoming = jsonResponse['data'] ?? [];
        final List<Booking> bookingList =
            upcoming.map((json) => Booking.fromJson(json)).toList();
        upcomingBooking.value = bookingList;
        lastBookingFetched = DateTime.now();
        // تخزين البيانات الخام في الكاش
        if (bookingList.isNotEmpty &&
            (upcomingBooking.isEmpty ||
                bookingList.first.status != upcomingBooking.first.status ||
                bookingList.first.date != upcomingBooking.first.date)) {
          upcomingBooking.value = bookingList;
          lastFetched = DateTime.now();
          await myServices.storeData('upcomingBooking', upcoming);
        }
      } else {
        errorMessage.value = 'Failed to load booking: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      loadingStates[key] = false;
    }
  }

  void loadCachedBooking() {
    final cachedData = myServices.getData('upcomingBooking');
    List<dynamic> dataList = [];

    if (cachedData != null) {
      if (cachedData is List) {
        dataList = cachedData;
      } else if (cachedData is Map) {
        // إذا كانت البيانات مخزنة كـ Map، نستخدم قيمها
        dataList = cachedData.values.toList();
      }
      upcomingBooking.value = dataList
          .map((json) => Booking.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }
  }

  RxInt unreadNotifications = 3.obs;
  RxMap<String, String> nextAppointment = {
    "doctor": "د.عزام الخطري ",
    "date": "10 فبراير 2025",
    "time": "10:30 صباحًا",
    "type": "استشارة أعصاب"
  }.obs;

  @override
  void onInit() async {
    await fetchDoctors();
    loadCachedBooking();
    await fetchLatestBookingFromServer();

    super.onInit();
  }
}
