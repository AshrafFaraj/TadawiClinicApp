import 'package:flutter/material.dart';

class CustomAuthTitle extends StatelessWidget {
  const CustomAuthTitle({
    super.key,
    required this.textTitle,
  });
  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        textTitle,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
