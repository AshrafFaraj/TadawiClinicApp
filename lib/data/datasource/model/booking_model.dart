class Booking {
  final int id;
  final int doctorId;
  final String doctorName;
  final String date;
  final String status;
  final String type;
  DateTime? lastUpdated;

  Booking({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.status,
    required this.type,
    this.lastUpdated,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
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
