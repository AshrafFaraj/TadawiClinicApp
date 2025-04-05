import 'package:flutter/material.dart';
import 'package:neurology_clinic/core/layouts/app_color_theme.dart';

class BuildSectionTitle extends StatelessWidget {
  const BuildSectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColorTheme.backgroundDark,
        ),
      ),
    );
  }
}
