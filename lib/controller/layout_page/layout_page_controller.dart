import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/screens/ai_page/ai_page.dart';
import 'package:neurology_clinic/view/screens/appointment_page/appointment_page.dart';
import 'package:neurology_clinic/view/screens/home/home_page.dart';
import 'package:neurology_clinic/view/screens/profile/profile_page.dart';

class LayoutPageController extends GetxController {
  int selectedIndex = 0;
  final List<IconData> icons = [
    Icons.home,
    Icons.notifications,
    Icons.favorite,
    Icons.person,
  ];
  List<Widget>pages=[HomePage(),AiPage(),AppointmentPage(),ProfilePage()];
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
