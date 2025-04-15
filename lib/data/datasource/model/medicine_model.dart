class Medicine {
  String? name;
  String? company;

  Medicine({this.name, this.company});

  factory Medicine.fromMap(Map<String, dynamic> json) => Medicine(
        name: json['name'],
        company: json['company'],
       
      );
       static Medicine fromMedicine(Medicine medicine) {
    return Medicine(
      name: medicine.name,
      company: medicine.company,
    );
  }

  Medicine toMedicine() {
    return Medicine(
      name: name,
      company: company,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'company': company,
        
      };
}

