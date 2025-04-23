import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '/controller/app_layout/app_layout_controller.dart';
import '../widgets/navigation/custom_tab_bar.dart';
import '../../core/layouts/app_color_theme.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  static const String route = '/course-rive';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        body: Stack(children: [
          Positioned(child: Container(color: AppColorTheme.background2)),
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
        ]),
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
