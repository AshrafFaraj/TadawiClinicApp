import 'package:get/get.dart';

import 'core/class/status_request.dart';
import 'data/datasource/remote/signup_data.dart';

class TestController extends GetxController {
  SignUpData signUpData = SignUpData(Get.find());
  List data = [];
  late StatusRequest statusRequest;

  @override
  void onInit() {
    super.onInit();
  }
}
