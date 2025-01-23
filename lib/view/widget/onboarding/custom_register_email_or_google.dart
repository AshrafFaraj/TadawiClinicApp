import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_register_dialog.dart';

class CustomRegisterByEmailOrGoogle extends StatelessWidget {
  const CustomRegisterByEmailOrGoogle({super.key, required this.onClosed});
  final ValueChanged onClosed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
              customRegisterDialog(context, onClosed: onClosed);
            },
            icon: SvgPicture.asset(
              "assets/icons/email_box.svg",
              height: 64,
              width: 64,
            )),
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/google_box.svg",
              height: 64,
              width: 64,
            ))
      ],
    );
  }
}
