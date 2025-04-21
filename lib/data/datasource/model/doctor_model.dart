import 'package:intl/intl.dart';

import 'doctor_schedule.dart';

/// نموذج بيانات الطبيب مع بيانات المستخدم وجدول الدوام
class Doctor {
  final int id;
  final int userId;
  final String specialization;
  final String address;
  final String about;
  final int experienceYears;
  final String? landlinePhone;
  final int? detectionPrice;
  final bool isAvailable;
  // بيانات المستخدم المرتبطة بالطالب
  final String name;
  final String? mobile;
  final String? profileImage;
  // دوام الطبيب
  final List<DoctorSchedule> schedules;

  Doctor({
    required this.id,
    required this.userId,
    required this.specialization,
    required this.address,
    required this.about,
    required this.experienceYears,
    this.landlinePhone,
    this.detectionPrice,
    required this.isAvailable,
    required this.name,
    this.mobile,
    this.profileImage,
    required this.schedules,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // جلب بيانات الدوام إذا وُجدت
    List<DoctorSchedule> schedulesList = [];
    if (json['schedules'] != null && json['schedules'] is List) {
      schedulesList = (json['schedules'] as List)
          .map((e) => DoctorSchedule.fromJson(e))
          .toList();
    }

    return Doctor(
      id: json['id'],
      userId: json['user_id'],
      specialization: json['specialization'] ?? '',
      address: json['address'] ?? '',
      about: json['about'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      landlinePhone: json['landline_phone'] ?? '',
      detectionPrice: json['detection_price'],
      isAvailable: json['is_available'] == 1 ? true : false,
      name: json['user'] != null ? json['user']['name'] ?? '' : '',
      mobile: json['user'] != null ? json['user']['mobile'] : null,
      profileImage: json['user'] != null ? json['user']['profile_image'] : null,
      schedules: schedulesList,
    );
  }
   // Method to get today's day in the same format as the schedule day
  String getTodayDay() {
    return DateFormat('EEEE').format(DateTime.now()); // e.g., "Saturday"
  }

  // Method to get today's schedule for a doctor
  List<DoctorSchedule> getTodaysSchedule() {
    String todayDay = getTodayDay();
    return schedules.where((schedule) => schedule.day == todayDay).toList();
  }

  // Method to get the complete schedule for a doctor
  List<DoctorSchedule> getSchedule() {
    return schedules;
  }
}
