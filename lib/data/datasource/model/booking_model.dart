import '/data/datasource/model/second_doctor_model.dart';

class Booking {
  int? id;
  int? patientId;
  int? doctorId;
  String? date;
  String? time;
  String? type;
  String? status;
  int? isPaid;
  DoctorModel? doctor;
  String? createdAt;
  String? updatedAt;

  Booking(
      {this.id,
      this.patientId,
      this.doctorId,
      this.date,
      this.time,
      this.type,
      this.status,
      this.isPaid,
      this.doctor,
      this.createdAt,
      this.updatedAt});

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        id: json['id'],
        patientId: json['patient_id'],
        doctorId: json['doctor_id'],
        time: json['time'],
        date: json['date'],
        type: json['type'],
        status: json['status'],
        isPaid: json['is_paid'],
        doctor:
            json['doctor'] == null ? null : DoctorModel.fromMap(json['doctor']),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'patient_id': patientId,
        'doctor_id': doctorId,
        'time': time,
        'date': date,
        'type': type,
        'status': status,
        'is_paid': isPaid,
        'doctor': doctor,
        'created_at': createdAt,
        'updated_at': updatedAt,
        // 'medicine':
        //     medicine != null ? Medicine.fromLocation(medicine!).toMap() : null,
      };
}

class Appointment {
  final int id;
  final int doctorId;
  final String doctorName;
  final String date;
  final String status;
  final String type;
  DateTime? lastUpdated;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.status,
    required this.type,
    this.lastUpdated,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'],
      date: json['date'],
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
      'status': status,
      'type': type,
      'last_updated': lastUpdated?.toIso8601String(),
    };
  }
}
