import 'package:neurology_clinic/core/constant/app_color.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? customAppBar({required String title}) {
  return AppBar(
    toolbarHeight: 30,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          color: AppColor.grey, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
