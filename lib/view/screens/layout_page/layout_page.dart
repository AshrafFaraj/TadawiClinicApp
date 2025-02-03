import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/core/constants/app_svg.dart';
import 'package:neurology_clinic/core/functions/calculate_line_position.dart';

import '../../../controller/layout_page/layout_page_controller.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LayoutPageController());
    final size = MediaQuery.of(context).size;
    final double margin = 10.0;
    return GetBuilder<LayoutPageController>(
      builder: (controller) {
        return Scaffold(
            body: controller.pages[controller.selectedIndex],
            bottomNavigationBar: NavFlow(
              backgroundColor: Colors.blue,
              iconFilledColor: Colors.grey,
              iconOutlinedColor: Colors.white,
              lineColor: Colors.grey,
              size: size,
              margin: margin,
              selectedIndex: controller.selectedIndex,
              icons: [
                NavIcon(
                  svg: AppSvg.home,
                ),
                NavIcon(
                  svg: AppSvg.chat,
                ),
                NavIcon(
                  svg: AppSvg.calendarIcon,
                ),
                NavIcon(
                  svg: AppSvg.profile,
                ),
              ],
              onTap: (value) {
                controller.changeIndex(value);
              },
            ));
      },
    );
  }
}

class NavFlow extends StatelessWidget {
  const NavFlow({
    super.key,
    required this.size,
    required this.margin,
    required this.selectedIndex,
    required this.icons,
    required this.onTap,
    required this.iconOutlinedColor,
    required this.iconFilledColor,
    required this.backgroundColor,
    required this.lineColor,
  });

  final Size size;
  final double margin;
  final int selectedIndex;
  final List<NavIcon> icons;
  final ValueChanged<int> onTap;
  final Color iconOutlinedColor;
  final Color iconFilledColor;
  final Color backgroundColor;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.08, // Dynamic height based on screen size
      margin: EdgeInsets.all(margin), // Margin around the navigation bar
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: icons.map((icon) {
              int index = icons.indexOf(icon);
              return GestureDetector(
                onTap: () => onTap(index),
                child: NavIcon(
                  svg: icon.svg,
                  color: selectedIndex == index
                      ? iconFilledColor
                      : iconOutlinedColor, // Selected icon color
                ),
              );
            }).toList(),
          ),
          // Animated line
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: calculateLinePosition(size.width, margin, icons.length,
                selectedIndex), // Adjusted for margin
            top: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0), // Padding above the line
              child: Container(
                width: 50, // Width of the line
                height: 4, // Height of the line
                decoration: BoxDecoration(
                  color: lineColor, // Color of the line
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  const NavIcon({
    super.key,
    this.color = Colors.white,
    required this.svg, // Default color for unselected icons
  });

  final Color color;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0), // Padding around each icon
      child: SvgPicture.asset(
        svg,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
