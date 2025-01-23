// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAuthBotton extends StatelessWidget {
  CustomAuthBotton({
    Key? key,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFF77D8E),
    required this.title,
    this.iconColor = const Color(0xFFFE0037),
  }) : super(key: key);

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24),
      child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(double.infinity, 56),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)))),
          icon: Icon(
            CupertinoIcons.arrow_right,
            color: iconColor,
          ),
          label: Text(title)),
    );
  }
}
