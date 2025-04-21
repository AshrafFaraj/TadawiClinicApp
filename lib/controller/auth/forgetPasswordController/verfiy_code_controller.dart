import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/core/constants/app_route_name.dart';
import '/services/services.dart';

import '../../../link_api.dart';

abstract class AppVerfiyCodeController extends GetxController {
  verifyOtp(String otpCode);
}

class AppVerfiyCodeControllerImp extends AppVerfiyCodeController {
  String? email;
  String? nextRoute;

  @override
  void verifyOtp(String otpCode) async {
    try {
      final response = await http.post(
        Uri.parse(AppLink.verifyOtpCode),
        headers: {
          "Content-Type": "application/json",
          "User-Agent": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({
          "email": email,
          "otp": otpCode,
        }),
      );
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        MyServices myServices = Get.find<MyServices>();
        await myServices.storeData('userData', jsonResponse['data']);
        myServices.fetchUserDatafromCach;

        Get.snackbar("نجاح", jsonResponse['message']);
        Get.offAndToNamed(nextRoute!, arguments: {
          'email': email,
          if (nextRoute == AppRouteName.resetPassword) 'reason': 'forget'
        });
      } else {
        Get.snackbar("فشل", jsonResponse['message']);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    nextRoute = Get.arguments['nextRoute'];
  }
}
