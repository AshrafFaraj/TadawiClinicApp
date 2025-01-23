import 'package:flutter/material.dart';

class CustomPositionImage extends StatelessWidget {
  CustomPositionImage({
    super.key,
    required this.image,
    required this.width,
    this.bottom,
    this.left,
  });
  final Image image;
  final double width;
  double? bottom;
  double? left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        width: width,
        bottom: bottom,
        left: left,
        child: image);
  }
}
