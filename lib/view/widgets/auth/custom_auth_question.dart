import 'package:flutter/material.dart';

import '../../../core/layouts/app_color_theme.dart';

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
        Text(
          "$constText ؟  ",
          style: const TextStyle(
              letterSpacing: -1,
              color: AppColorTheme.background2,
              fontSize: 17),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            clickText,
            style: const TextStyle(
                letterSpacing: -1,
                color: AppColorTheme.background3,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        )
      ],
    );
  }
}
