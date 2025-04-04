import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'menu_row.dart';
import '../../../data/datasource/model/menu_item.dart';
import '../../../core/layouts/app_color_theme.dart';
import '../../../core/constants/assets.dart' as app_assets;

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final List<MenuItemModel> _browseMenuIcons = MenuItemModel.menuItems;
  final List<MenuItemModel> _historyMenuIcons = MenuItemModel.menuItems2;
  final List<MenuItemModel> _themeMenuIcon = MenuItemModel.menuItems3;
  String _selectedMenu = MenuItemModel.menuItems[0].title;
  bool _isDarkMode = false;

  void onThemeRiveIconInit(artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, _themeMenuIcon[0].riveIcon.stateMachine);
    artboard.addController(controller!);
    _themeMenuIcon[0].riveIcon.status =
        controller.findInput<bool>("active") as SMIBool;
  }

  void onMenuPress(MenuItemModel menu) {
    setState(() {
      _selectedMenu = menu.title;
    });
  }

  void onThemeToggle(value) {
    setState(() {
      _isDarkMode = value;
    });
    _themeMenuIcon[0].riveIcon.status!.change(value);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin:
            EdgeInsets.only(right: MediaQuery.of(context).size.width - width),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        width: width,
        decoration: BoxDecoration(
          color: AppColorTheme.background2,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Ashraf",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "Inter"),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Software Engineer",
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 15,
                            fontFamily: "Inter"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MenuButtonSection(
                        title: "BROWSE",
                        selectedMenu: _selectedMenu,
                        menuIcons: _browseMenuIcons,
                        onMenuPress: onMenuPress),
                    MenuButtonSection(
                        title: "HISTORY",
                        selectedMenu: _selectedMenu,
                        menuIcons: _historyMenuIcons,
                        onMenuPress: onMenuPress),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Opacity(
                    opacity: 0.6,
                    child: RiveAnimation.asset(
                      app_assets.iconsRiv,
                      stateMachines: [_themeMenuIcon[0].riveIcon.stateMachine],
                      artboard: _themeMenuIcon[0].riveIcon.artboard,
                      onInit: onThemeRiveIconInit,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    _themeMenuIcon[0].title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                CupertinoSwitch(value: _isDarkMode, onChanged: onThemeToggle),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class MenuButtonSection extends StatelessWidget {
  const MenuButtonSection(
      {Key? key,
      required this.title,
      required this.menuIcons,
      this.selectedMenu = "Home",
      this.onMenuPress})
      : super(key: key);

  final String title;
  final String selectedMenu;
  final List<MenuItemModel> menuIcons;
  final Function(MenuItemModel menu)? onMenuPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 15,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var menu in menuIcons) ...[
                Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    thickness: 1,
                    height: 1,
                    indent: 16,
                    endIndent: 16),
                MenuRow(
                  menu: menu,
                  selectedMenu: selectedMenu,
                  onMenuPress: () => onMenuPress!(menu),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
