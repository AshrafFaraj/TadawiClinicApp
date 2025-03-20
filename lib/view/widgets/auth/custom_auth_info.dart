import 'package:flutter/material.dart';

import '../../../core/layouts/rive_theme.dart';

class CustomAuthInfo extends StatelessWidget {
  const CustomAuthInfo({super.key, required this.textInfo});
  final String textInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      child: Text(
        textInfo,
        // style: Theme.of(context).textTheme.bodyMedium,
        style: const TextStyle(color: RiveAppTheme.background2),
        textAlign: TextAlign.center,
      ),
    );
  }
}
