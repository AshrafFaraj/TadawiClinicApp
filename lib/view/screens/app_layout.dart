import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'dart:math' as math;

import '/controller/app_layout/app_layout_controller.dart';
import '../widgets/navigation/custom_tab_bar.dart';
import '../widgets/navigation/side_menu.dart';
import '../../core/layouts/app_color_theme.dart';
import '../../core/constants/assets.dart' as app_assets;

// Common Tab Scene for the tabs other than 1st one, showing only tab name in center
// Widget commonTabScene(String tabName) {
//   return Container(
//       color: RiveAppTheme.background,
//       alignment: Alignment.center,
//       child: Text(tabName,
//           style: const TextStyle(
//               fontSize: 28, fontFamily: "Poppins", color: Colors.black)));
// }

class RiveAppHome extends StatelessWidget {
  const RiveAppHome({Key? key}) : super(key: key);

  static const String route = '/course-rive';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutPageController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Positioned(child: Container(color: AppColorTheme.background2)),
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: controller.sidebarAnim,
                builder: (BuildContext context, Widget? child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(((1 - controller.sidebarAnim.value) * -30) *
                          math.pi /
                          180)
                      ..translate((1 - controller.sidebarAnim.value) * -300),
                    child: child,
                  );
                },
                child: FadeTransition(
                  opacity: controller.sidebarAnim,
                  child: const SideMenu(),
                ),
              ),
            ),
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: controller.showOnBoarding
                    ? controller.onBoardingAnim
                    : controller.sidebarAnim,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 -
                        (controller.showOnBoarding
                            ? controller.onBoardingAnim.value * 0.08
                            : controller.sidebarAnim.value * 0.1),
                    child: Transform.translate(
                      offset: Offset(controller.sidebarAnim.value * 265, 0),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY((controller.sidebarAnim.value * 30) *
                              math.pi /
                              180),
                        child: child,
                      ),
                    ),
                  );
                },
                child: controller.tabBody,
              ),
            ),
            RepaintBoundary(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AnimatedBuilder(
                  animation: controller.sidebarAnim,
                  builder: (context, child) {
                    return SafeArea(
                      child: Row(
                        children: [
                          SizedBox(width: controller.sidebarAnim.value * 216),
                          child!,
                        ],
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: controller.onMenuPress,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 44,
                        height: 44,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44 / 2),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColorTheme.shadow.withValues(alpha: 0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: RiveAnimation.asset(
                          app_assets.menuButtonRiv,
                          stateMachines: const ["State Machine"],
                          animations: const ["open", "close"],
                          onInit: controller.onMenuIconInit,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: RepaintBoundary(
          child: AnimatedBuilder(
            animation: !controller.showOnBoarding
                ? controller.sidebarAnim
                : controller.onBoardingAnim,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                    0,
                    !controller.showOnBoarding
                        ? controller.sidebarAnim.value * 300
                        : controller.onBoardingAnim.value * 200),
                child: child,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomTabBar(
                  getController: controller,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
