class Patient {
  String name;
  // String avatarUrl;
  String bloodType;
  List<String> allergies;
  List<String> medications;

  Patient({
    required this.name,
    // required this.avatarUrl,
    required this.bloodType,
    required this.allergies,
    required this.medications,
  });
}
