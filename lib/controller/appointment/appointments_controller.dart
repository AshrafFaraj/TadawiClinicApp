import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  
  void switchToUpcomingTab() {
    tabController.index = 0; // Switch to Tab 1
  }
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
