import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';
import 'package:neurology_clinic/link_api.dart';
import 'package:neurology_clinic/services/services.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileController extends GetxController {
  late MyServices myServices;
  ProfileStatus status = ProfileStatus.initial;
  String token = "";
  File? selectedImage;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

   // Pick image from gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      update(); // manually trigger UI update
    }
  }

  // Upload image to Laravel API
  Future<void> uploadImage() async {
    if (selectedImage == null) {
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

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        selectedImage!.path,
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        final res = await response.stream.bytesToString();
        final json = jsonDecode(res);

        Get.snackbar("Success", json['message']);
        selectedImage = null; // Reset image
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
    super.onInit();
  }
}
