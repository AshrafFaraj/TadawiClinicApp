import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';
import 'package:neurology_clinic/link_api.dart';
import 'package:neurology_clinic/services/services.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileController extends GetxController {
  late MyServices myServices;
  ProfileStatus status = ProfileStatus.initial;
  String token = "";
  File? profileImage;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  String ?imageUrl ;

  // Pick image from gallery
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(title: 'Crop Image'),
        ],
      );

      if (croppedFile != null) {
        profileImage = File(croppedFile.path);
        update(); // 🧠 update UI
        uploadImage();
      }
    }
  }

  Future<void> getImage() async {
    final response = await http.get(
      Uri.parse(AppLink.getImage),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      imageUrl = data['image_url'];
      update();
    }

    imageUrl = "";
    update();
  }

  // Upload image to Laravel API
  Future<void> uploadImage() async {
    if (profileImage == null) {
      Get.snackbar("Error", "No image selected");
      return;
    }

    try {
      isLoading = true;
      update();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppLink.uploadImage),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.files.add(await http.MultipartFile.fromPath(
        'profile_image', // MUST match Laravel's validation key
        profileImage!.path,
      ));

      var response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        final res = await response.stream.bytesToString();
        final json = jsonDecode(res);
        getImage();

        Get.snackbar("Success", json['message']);
        profileImage = null; // Reset image
      } else {
        Get.snackbar("Error", "Image upload failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update(); // refresh UI
    }
  }

  Future<void> logout() async {
    try {
      status = ProfileStatus.loading;
      update();
      final response = await http.post(
        Uri.parse(AppLink.logout),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        status = ProfileStatus.success;
        update();
        Get.offAllNamed(AppRouteName
            .onBoarding); // Use GetX to navigate to the onboarding screen
      } else {
        status = ProfileStatus.failure;
        update();

        Get.snackbar('Error', 'Failed to log out. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to log out. Please try again.');
    }
  }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    token = myServices.userData['token'];
    getImage();
    super.onInit();
  }
}
