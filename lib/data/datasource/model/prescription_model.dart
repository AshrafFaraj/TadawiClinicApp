import 'dart:convert';

import 'medicine_model.dart';

class Prescription {
  int? id;
  String? dosage;
  String? duration;
  String? time;
  String? usage;
  String? notes;
  String? bookingDate;
  Medicine? medicine;

  Prescription(
      {this.id,
      this.dosage,
      this.duration,
      this.time,
      this.usage,
      this.notes,
      this.medicine,
      this.bookingDate});

       factory Prescription.fromRawJson(String str) =>
      Prescription.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());
  factory Prescription.fromMap(Map<String, dynamic> json) => Prescription(
        dosage: json['dosage'],
        duration: json['duration'],
        time: json['time'],
        usage: json['usage'],
        notes: json['notes'],
        medicine: json['medicine'] == null
            ? null
            : Medicine.fromMap(json['medicine']),
            bookingDate: json['booking_date'],
      );

  Map<String, dynamic> toMap() => {
        'dosage': dosage,
        'duration': duration,
        'time': time,
        'usage': usage,
        'notes': notes,
        'medicine':
            medicine != null ? Medicine.fromMedicine(medicine!).toMap() : null,
        'booking_date':bookingDate
      };
}
