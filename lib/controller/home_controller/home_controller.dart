import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../data/datasource/model/doctor_model.dart';
import '../../link_api.dart';
import '../../services/services.dart';

class HomeController extends GetxController {
  final MyServices myServices = Get.find<MyServices>();
  RxBool isLoading = false.obs;
  var doctors = <Doctor>[].obs;
  var errorMessage = ''.obs;

  // توقيت آخر جلب للبيانات
  DateTime? lastFetched;
  // مدة صلاحية التخزين المؤقت (10 دقائق)
  static const cacheDuration = Duration(minutes: 10);

  // دالة لجلب بيانات الأطباء من API مع استخدام Caching
  Future<void> fetchDoctors({bool forceRefresh = false}) async {
    // التحقق من وجود بيانات مخزنة وأنها لم تنتهِ صلاحيتها
    if (!forceRefresh && lastFetched != null) {
      final difference = DateTime.now().difference(lastFetched!);
      if (difference < cacheDuration) {
        // البيانات ما زالت صالحة، فلا حاجة لإعادة الطلب
        return;
      }
    }
    try {
      isLoading.value = true;
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
      isLoading.value = false;
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
    super.onInit();
  }
}
