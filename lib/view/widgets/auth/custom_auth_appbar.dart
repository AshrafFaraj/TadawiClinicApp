import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';

PreferredSizeWidget? customAppBar({required String title}) {
  return AppBar(
    toolbarHeight: 30,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
          color: AppColor.grey, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
