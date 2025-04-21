class Appointment {
  final int id;
  final int doctorId;
  final String doctorName;
  final String date;
  final DateTime time;
  final String status;
  final String type;
  DateTime? lastUpdated;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.status,
    required this.type,
    this.lastUpdated,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    // محاولة تحليل التاريخ والوقت، أو تعيين الوقت الحالي إن لم يكن موجودًا أو غير صالح
    final parsedTime =
        json['time'] != null ? DateTime.tryParse(json['time']) : null;
    return Appointment(
      id: json['id'],
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'],
      date: json['date'],
      time: parsedTime ?? DateTime.now(), // ← ← ← ضمان عدم وجود null
      status: json['status'],
      type: json['type'],
      lastUpdated: json['last_updated'] != null
          ? DateTime.tryParse(json['last_updated'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'date': date,
      'time': time.toIso8601String(), // ← لم تعد nullable
      'status': status,
      'type': type,
      'last_updated': lastUpdated?.toIso8601String(),
    };
  }
}
