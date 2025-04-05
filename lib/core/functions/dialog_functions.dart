import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSuccessDialog(
    {required BuildContext context,
    void Function()? btnOkOnPress,
    String? btnOkText,
    String? title,
    String? desc}) {
  AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    btnOkText: btnOkText,
    title: title,
    desc: desc,
    descTextStyle: TextStyle(color: Colors.black),
    btnOkOnPress: btnOkOnPress,
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}

showErrorDialog(
    {required BuildContext context,
    String? btnOkText,
    String? title,
    String? desc}) {
  AwesomeDialog(
    context: Get.context!,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    btnOkText: btnOkText,
    title: title,
    desc: desc,
    descTextStyle: TextStyle(color: Colors.black),
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  ).show();
}

showWarningDialog({
  required BuildContext context,
  String? btnOkText,
  String? title,
  String? desc,
  String? btnCancelText,
  void Function()? btnOkOnPress,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title,
    desc: desc,
    btnCancelText: btnCancelText,
    btnOkText: btnOkText,
    descTextStyle: TextStyle(color: Colors.black),
    buttonsTextStyle: const TextStyle(color: Colors.white),
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: btnOkOnPress,
  ).show();
}
