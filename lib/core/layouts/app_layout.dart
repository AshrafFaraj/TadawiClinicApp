import 'package:flutter/material.dart';

Text textWidget(
    {required String text,
    Color? textColor,
    FontWeight? fontWeight,
    double? fontSize}) {
  return Text(
    text,
    style: TextStyle(
      color: textColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
    ),
  );
}
