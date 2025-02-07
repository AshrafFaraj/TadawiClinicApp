import 'package:flutter/material.dart';

class CustomAuthTitle extends StatelessWidget {
  const CustomAuthTitle({
    super.key,
    required this.textTitle,
  });
  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      textTitle,
      style: Theme.of(context).textTheme.displayMedium,
      textAlign: TextAlign.center,
    );
  }
}
