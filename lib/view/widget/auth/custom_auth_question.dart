import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';

class CustomAuthQuestion extends StatelessWidget {
  const CustomAuthQuestion(
      {super.key,
      required this.constText,
      required this.clickText,
      this.onTap});
  final String constText;
  final String clickText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$constText ؟  "),
        InkWell(
          onTap: onTap,
          child: Text(
            clickText,
            style: const TextStyle(
                color: AppColor.primaycolor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
