import 'package:flutter/material.dart';

class CustomAuthInfo extends StatelessWidget {
  const CustomAuthInfo({super.key, required this.textInfo});
  final String textInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      child: Text(
        textInfo,
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
