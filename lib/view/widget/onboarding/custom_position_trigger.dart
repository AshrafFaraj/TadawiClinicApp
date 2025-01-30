import 'package:flutter/material.dart';

class CustomPositionedTrigger extends StatelessWidget {
  const CustomPositionedTrigger(
      {super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
        ],
      ),
    );
  }
}
