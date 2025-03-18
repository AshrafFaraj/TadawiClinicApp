import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/datasource/model/user_model.dart';

class AuthService extends GetxService {
  final String baseUrl = ''; // غيّر الرابط حسب سيرفرك

  // دالة التسجيل
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required int age,
    required String address,
    required String gender,
    required String mobile,
    required String bloodType,
  }) async {
    final url = Uri.parse("$baseUrl/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "age": age,
          "address": address,
          "gender": gender,
          "mobile": mobile,
          "blood_type": bloodType,
        }),
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)['message'] ?? "خطأ غير متوقع!";
      }
    } catch (e) {
      throw "حدث خطأ أثناء التسجيل: $e";
    }
  }
}
