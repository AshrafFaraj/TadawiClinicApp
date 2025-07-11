import 'package:flutter/material.dart';
import 'package:neurology_clinic/core/layouts/app_color_theme.dart';

class BuildSelectableCard extends StatelessWidget {
  const BuildSelectableCard(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onTap,
      this.gradient});

  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          gradient: gradient,
          color: isSelected ? AppColorTheme.background3 : AppColorTheme.card,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: isSelected ? Colors.blue[900] : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              text == 'ذكر'
                  ? const Icon(Icons.male, color: Colors.white)
                  : text == 'أنثى'
                      ? const Icon(Icons.female, color: Colors.white)
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
