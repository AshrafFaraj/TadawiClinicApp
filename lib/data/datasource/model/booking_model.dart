import 'doctor_model.dart';

class Booking {
  int? id;
  int? patientId;
  int? doctorId;
  String? date;
  String? type;
  String? status;
  int? isPaid;
  Doctor? doctor;
  String? createdAt;
  String? updatedAt;

  Booking(
      {this.id,
      this.patientId,
      this.doctorId,
      this.date,
      this.type,
      this.status,
      this.isPaid,
      this.doctor,
      this.createdAt,
      this.updatedAt});

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        id: json['id'],
        patientId: json['patientId'],
        doctorId: json['doctorId'],
        date: json['date'],
        type: json['type'],
        status: json['status'],
        isPaid: json['isPaid'],
        doctor:
            json['doctor'] == null ? null : Doctor.fromMap(json['doctor']),
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'patientId': patientId,
        'doctorId': doctorId,
        'date': date,
        'type': type,
        'status': status,
        'isPaid': isPaid,
        'doctor': doctor,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        // 'medicine':
        //     medicine != null ? Medicine.fromLocation(medicine!).toMap() : null,
      };
}
