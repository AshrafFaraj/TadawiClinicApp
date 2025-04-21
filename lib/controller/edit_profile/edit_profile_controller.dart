import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/services.dart';
import 'package:http/http.dart' as http;

enum EditProfileStatus { initial, loading, success, failure }

class EditProfileController extends GetxController {
  String selectedGender = "";
  String selectedBloodType = 'A+';
  String name = "";
  String address = "";
  int id = 0;
  String mobile = "";
  String? token;
  late MyServices myServices;
  List<String> genders = ['male', 'female'];
  List<String> bloodType = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  EditProfileStatus status = EditProfileStatus.initial;
  changeGender(String gender) {
    selectedGender = gender;
    update();
  }

  Future<void> updateProfile(
      String nameValue, String phoneValue, String addressValue) async {
    try {
      status = EditProfileStatus.loading;
      update();
      // Replace with the actual URL of your API endpoint
      final url = Uri.parse('http://10.0.2.2:8000/api/v1/patients/$id');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Replace with your auth token
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': nameValue,
          'mobile': phoneValue.toString(),
          'address': addressValue,
          'gender': selectedGender,
          'blood_type': selectedBloodType,
        }),
      );

      if (response.statusCode == 200) {
        // Booking deleted successfully
        final data = jsonDecode(response.body);
        await myServices.storeData('userData', data);
        myServices.userData.value = Map<String, dynamic>.from(data);
        status = EditProfileStatus.success;
        update();
      } else {
        status = EditProfileStatus.failure;
        update();
        Get.snackbar('Error', 'Failed to delete booking');
      }
      print(response.body);
    } on SocketException catch (e) {
      Get.snackbar(
        'خطأ', // No title
        'هناك خطأ في الشبكة', // Message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      status = EditProfileStatus.failure;
      update();
    }
  }

  changeBloodType(String bloodType) {
    selectedBloodType = bloodType;
    update();
  }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    // id = myServices.userData['patient']['id'];
    token = myServices.userData['token'];
    name = myServices.userData['user']['name'] ?? "";
    mobile = myServices.userData['user']['mobile'] ?? "";
    address = myServices.userData['patient']['address'] ?? "";
    selectedBloodType = myServices.userData['patient']['blood_type'] ?? "";
    selectedGender = myServices.userData['user']['gender'] ?? "";
    print(myServices.userData);
    print("$name ==========");
    print(myServices.userData['user']['gender']);
    super.onInit();
  }
}
