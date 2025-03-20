class UserModel {
  final String name;
  final String email;
  final String token;

  UserModel({required this.name, required this.email, required this.token});

  // تحويل JSON إلى كائن UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'],
    );
  }
}
