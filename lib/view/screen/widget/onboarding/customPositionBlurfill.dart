import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPositionBlurfill extends StatelessWidget {
  const CustomPositionBlurfill({super.key,required this.sigmaX,required this.sigmaY, this.child});
  final double sigmaX;
  final double sigmaY;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: child,
        ));
  }
}
