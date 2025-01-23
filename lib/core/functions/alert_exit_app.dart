import 'dart:io';
import 'package:neurology_clinic/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
