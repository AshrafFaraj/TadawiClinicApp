import 'package:flutter/material.dart';

class PrescriptionTakesWidget extends StatelessWidget {
  const PrescriptionTakesWidget({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size.width * .25,
      height: size.height * .05,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 226, 231, 246),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}