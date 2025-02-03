import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController with GetSingleTickerProviderStateMixin  {
  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with 2 tabs
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    // Dispose the TabController
    tabController.dispose();
    super.onClose();
  }
}
