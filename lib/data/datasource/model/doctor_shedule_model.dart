class DoctorShedule {
  int? id;
  int? doctorId;
  String? day;
  String? startTime;
  String? endTime;

  DoctorShedule({
    this.id,
    this.doctorId,
    this.day,
    this.startTime,
    this.endTime,
  });

  factory DoctorShedule.fromMap(Map<String, dynamic> json) => DoctorShedule(
        id: json['id'],
        doctorId: json['doctor_id'],
        day: json['day'],
        startTime: json['start_time'],
        endTime: json['end_time'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'doctor_id': doctorId,
        'day': day,
        'start_time': startTime,
        'end_time': endTime,
      };
}
