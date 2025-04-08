import 'medicine_model.dart';

class Prescription {
  int? id;
  String? dosage;
  String? duration;
  String? time;
  String? usage;
  String? notes;
  Medicine? medicine;

  Prescription({this.id,this.dosage, this.duration,this.time,this.usage, this.notes, this.medicine});

  factory Prescription.fromMap(Map<String, dynamic> json) => Prescription(
        dosage: json['dosage'],
        duration: json['duration'],
        time: json['time'],
        usage: json['usage'],
        notes: json['notes'],
        medicine: json['medicine'] == null
            ? null
            : Medicine.fromMap(json['medicine']),
      );

  Map<String, dynamic> toMap() => {
        'dosage': dosage,
        'duration': duration,
        'time': time,
        'usage': usage,
        'notes': notes,
        // 'medicine':
        //     medicine != null ? Medicine.fromLocation(medicine!).toMap() : null,
      };
}
