import 'package:neurology_clinic/core/class/status_request.dart';
import 'package:neurology_clinic/data/datasource/remote/signup_data.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  SignUpData signUpData = SignUpData(Get.find());
  List data = [];
  late StatusRequest statusRequest;

  @override
  void onInit() {
    super.onInit();
  }
}
