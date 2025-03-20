import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/layouts/app_layout.dart';

class TimeElementsWidgets extends StatelessWidget {
  const TimeElementsWidgets({
    super.key,
    required this.size,
    required this.svg,
    required this.text,
  });

  final Size size;
  final String svg;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svg,
            // alignment: Alignment.center,
            fit: BoxFit.contain,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
          ),
          SizedBox(
            width: 5,
          ),
          textWidget(
              text: text,
              fontWeight: FontWeight.w300,
              fontSize: 15,
              textColor: Colors.black45)
        ],
      ),
    );
  }
}
