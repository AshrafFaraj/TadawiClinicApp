import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/services/services.dart';

class EditProfileController extends GetxController {
  late MyServices _myServices;

  late TextEditingController nameTextController;
  late TextEditingController mobileTextController;
  late TextEditingController addressTextController;
  String? selectedGender;
  late String? selectedBloodType;
  List<String> genders = ['male', 'female'];
  List<String> bloodType = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  changeGender(String gender) {
    selectedGender = gender;
    update();
  }

  changeBloodType(String bloodType) {
    selectedBloodType = bloodType;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _myServices = Get.find<MyServices>();
    nameTextController = TextEditingController();
    mobileTextController = TextEditingController();
    addressTextController = TextEditingController();

    nameTextController.text = _myServices.userData['user']['name'];
    mobileTextController.text =
        _myServices.userData['user']['mobile'].toString();
    addressTextController.text = _myServices.userData['patient']['address'];
    selectedBloodType = _myServices.userData['patient']['blood_type'];
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    mobileTextController.dispose();
    addressTextController.dispose();
  }
}
