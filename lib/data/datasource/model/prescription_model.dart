import 'medicine_model.dart';

class Prescription {
  String? dose;
  int? times;
  String? instructions;
  Medicine? medicine;

  Prescription({this.dose, this.times, this.instructions, this.medicine});

  factory Prescription.fromMap(Map<String, dynamic> json) => Prescription(
        dose: json['dose'],
        times: json['times'],
        instructions: json['instructions'],
        medicine: json['medicine'] == null
            ? null
            : Medicine.fromMap(json['medicine']),
      );

  Map<String, dynamic> toMap() => {
        'dose': dose,
        'times': times,
        'instructions': instructions,
        // 'medicine':
        //     medicine != null ? Medicine.fromLocation(medicine!).toMap() : null,
      };
}
