import 'package:get/get.dart';
import '../data/datasource/model/patient_model.dart';
import '../services/services.dart';

class HomeController extends GetxController {
  var patient;
// دالة لتحميل البيانات من SharedPreferences
  Future<void> loadProfileData() async {
    MyServices myServices = Get.find();
    patient = Patient(
      name: myServices.sharedPreferences.getString('name') ?? 'غير محدد',
      avatarUrl: "https://example.com/avatar.png",
      bloodType: "O+",
      allergies: ["الغبار", "البنسلين"],
      medications: ["باراسيتامول", "أوميبرازول"],
    ).obs;
  }

  var unreadNotifications = 3.obs;
  var nextAppointment = {
    "doctor": "د.عزام الخطري ",
    "date": "10 فبراير 2025",
    "time": "10:30 صباحًا",
    "type": "استشارة أعصاب"
  }.obs;

  @override
  void onInit() {
    loadProfileData();
    super.onInit();
  }
}
