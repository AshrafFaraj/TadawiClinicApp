import 'package:neurology_clinic/core/constant/app_color.dart';
import 'package:flutter/material.dart';

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
          child: Text(
            clickText,
            style: const TextStyle(
                color: AppColor.primaycolor, fontWeight: FontWeight.bold),
          ),
          onTap: onTap,
        )
      ],
    );
  }
}
