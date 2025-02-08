import 'package:get/get.dart';
import '../data/datasource/model/patient_model.dart';

class HomeController extends GetxController {
  var patient = Patient(
    name: "أشرف عبدالله",
    avatarUrl: "https://example.com/avatar.png",
    bloodType: "O+",
    allergies: ["الغبار", "البنسلين"],
    medications: ["باراسيتامول", "أوميبرازول"],
  ).obs;

  var unreadNotifications = 3.obs;
  var nextAppointment = {
    "doctor": "د.عزام الخطري ",
    "date": "10 فبراير 2025",
    "time": "10:30 صباحًا",
    "type": "استشارة أعصاب"
  }.obs;
}
