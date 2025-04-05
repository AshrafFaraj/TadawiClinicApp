import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_route_name.dart';
import 'locale/local.dart';
import 'locale/local_controller.dart';
import 'my_binding.dart';
import 'routes.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      translations: Applocal(),
      initialBinding: MyBinding(),
      initialRoute: AppRouteName.language,
      getPages: routes,
    );
  }
}
