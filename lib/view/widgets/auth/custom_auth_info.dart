import 'package:flutter/material.dart';

import '../../../core/layouts/app_color_theme.dart';

class CustomAuthInfo extends StatelessWidget {
  const CustomAuthInfo({super.key, required this.textInfo});
  final String textInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Text(
        textInfo,
        // style: Theme.of(context).textTheme.bodyMedium,
        style: const TextStyle(
            wordSpacing: 2,
            letterSpacing: -1,
            color: AppColorTheme.background2),
        textAlign: TextAlign.center,
      ),
    );
  }
}
