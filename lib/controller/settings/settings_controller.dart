import 'package:get/get.dart';
import 'package:neurology_clinic/data/datasource/model/language_model.dart';

import '../../locale/local_controller.dart';
import '../../services/services.dart';

class SettingsController extends GetxController {
  final LocalController localController = Get.find();
  final List<LanguageModel> list = [
    const LanguageModel(language: "العربية", value: "ar"),
    const LanguageModel(language: "English", value: "en"),
  ];
  late MyServices myServices;
  String? value;
  final selectedLanguage = Get.locale?.languageCode;
  changeValue(String selectedValue) {
    value = selectedValue;
    update();
  }

  check() {
    print(myServices.userData['patient']['id']);
    print(myServices.userData);
    print(myServices.userData['token']);
  }

  changeLanguage() {
    // localController.changeLang(value!);
  }

  checkValue() {
    value = selectedLanguage;
  }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    checkValue();
    super.onInit();
  }
}
