class Medicine {
  String? name;
  String? company;

  Medicine({this.name, this.company});

  factory Medicine.fromMap(Map<String, dynamic> json) => Medicine(
        name: json['name'],
        company: json['company'],
       
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'company': company,
        
      };
}

