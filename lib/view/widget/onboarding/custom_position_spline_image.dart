import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
    return Positioned(width: width, bottom: bottom, left: left, child: image);
  }
}
