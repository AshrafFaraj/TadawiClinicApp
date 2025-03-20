import 'package:get/get.dart';

class EditProfileController extends GetxController {
   String? selectedGender;
   String selectedBloodType='A+';
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
}
