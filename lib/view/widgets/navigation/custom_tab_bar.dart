import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide LinearGradient;

import '/controller/app_layout/app_layout_controller.dart';
import '../../../data/datasource/model/tab_item.dart';
import '../../../core/layouts/app_color_theme.dart';
import '../../../core/constants/assets.dart' as app_assets;

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.getController}) : super(key: key);

  final LayoutPageController getController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
        padding: const EdgeInsets.all(1),
        constraints: const BoxConstraints(maxWidth: 768),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: [
            Colors.white.withValues(alpha: 0.5),
            Colors.white.withValues(alpha: 0)
          ]),
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColorTheme.background2.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColorTheme.background2.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 20),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(getController.icons.length, (index) {
              TabItem icon = getController.icons[index];

              return Expanded(
                key: icon.id,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(12),
                  child: AnimatedOpacity(
                    opacity: getController.selectedTab == index ? 1 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: -4,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 4,
                              width:
                                  getController.selectedTab == index ? 20 : 0,
                              decoration: BoxDecoration(
                                color: AppColorTheme.accentColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: RiveAnimation.asset(
                              app_assets.iconsRiv,
                              stateMachines: [icon.stateMachine],
                              artboard: icon.artboard,
                              onInit: (artboard) {
                                getController.onRiveIconInit(artboard, index);
                              },
                            ),
                          )
                        ]),
                  ),
                  onPressed: () {
                    getController.onTabPress(index);
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
