import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_color.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
    title: "Warning",
    middleText: "Do you want get out of the app",
    actions: [
      MaterialButton(
          color: AppColor.primaycolor,
          onPressed: () {
            exit(0);
          },
          child: Text("Yes")),
      MaterialButton(
          color: AppColor.primaycolor,
          onPressed: () {
            Get.back();
          },
          child: Text("No")),
    ],
  );
  return Future.value(true);
}
