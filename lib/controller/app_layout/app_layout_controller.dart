import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../core/layouts/rive_theme.dart';
import '../../data/datasource/model/tab_item.dart';
import '../../view/screens/ai_chat/ai_chat_page.dart';
import '../../view/screens/appointment_page/appointment_page.dart';
import '../../view/screens/home/home_view.dart';
import '../../view/screens/profile/profile_page.dart';

class LayoutPageController extends GetxController
    with GetTickerProviderStateMixin {
  static const String route = '/course-rive';

  late AnimationController? animationController;
  late AnimationController? onBoardingAnimController;
  late Animation<double> onBoardingAnim;
  late Animation<double> sidebarAnim;

  late SMIBool menuBtn;
  bool showOnBoarding = false;
  Widget tabBody = Container(color: RiveAppTheme.background);

  final List<Widget> screens = [
    HomeView(),
    const AppointmentPage(),
    ChatPage(),
    const ProfilePage(),
  ];
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  final List<TabItem> icons = TabItem.tabItemsList;
  int selectedTab = 0;

  void onTabPress(int index) {
    if (selectedTab != index) {
      selectedTab = index;
      update();
      tabBody = screens[index];
      icons[index].status!.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        icons[index].status!.change(false);
      });
    }
  }

  void onRiveIconInit(Artboard artboard, index) {
    final controller = StateMachineController.fromArtboard(
        artboard, icons[index].stateMachine);
    artboard.addController(controller!);
    icons[index].status = controller.findInput<bool>("active") as SMIBool;
  }

  final springDesc = const SpringDescription(
    mass: 0.1,
    stiffness: 40,
    damping: 5,
  );

  void onMenuIconInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine");
    artboard.addController(controller!);
    menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
    menuBtn.value = true;
  }

  void presentOnBoarding(bool show) {
    if (show) {
      showOnBoarding = true;
      update();
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      onBoardingAnimController?.animateWith(springAnim);
    } else {
      onBoardingAnimController
          ?.reverse()
          .whenComplete(() => {showOnBoarding = false, update()});
    }
  }

  void onMenuPress() {
    if (menuBtn.value) {
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      animationController?.animateWith(springAnim);
    } else {
      animationController?.reverse();
    }
    menuBtn.change(!menuBtn.value);

    SystemChrome.setSystemUIOverlayStyle(
        menuBtn.value ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light);
  }

  @override
  // ignore: unused_element
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );
    onBoardingAnimController = AnimationController(
      duration: const Duration(milliseconds: 350),
      upperBound: 1,
      vsync: this,
    );

    sidebarAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.linear,
    ));

    onBoardingAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: onBoardingAnimController!,
      curve: Curves.linear,
    ));

    tabBody = screens.first;
  }

  @override
  void dispose() {
    animationController?.dispose();
    onBoardingAnimController?.dispose();
    super.dispose();
  }
}
