class DoctorModel {
  int? id;
  String? name;
  String? specialization;
  String? gender;
  String? mobile;
  String? landlinePhone;
  int? status;

  DoctorModel(
      {this.id,
      this.name,
      this.specialization,
      this.gender,
      this.mobile,
      this.landlinePhone,
      this.status
      });

  factory DoctorModel.fromMap(Map<String, dynamic> json) => DoctorModel(
        id: json['id'],
        name: json['name'],
        specialization: json['specialization'],
        gender: json['gender'],
        mobile: json['mobile'],
        landlinePhone: json['landlinePhone'],
        status: json['status'],
       
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'specialization': specialization,
        'gender': gender,
        'mobile': mobile,
        'landlinePhone': landlinePhone,
        'status': status,
      };
}