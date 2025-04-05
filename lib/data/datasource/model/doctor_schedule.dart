class DoctorSchedule {
  final int id;
  final int doctorId;
  final String day;
  final String startTime;
  final String endTime;

  DoctorSchedule({
    required this.id,
    required this.doctorId,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      id: json['id'],
      doctorId: json['doctor_id'],
      day: json['day'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }
}
