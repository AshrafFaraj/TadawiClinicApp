import 'package:flutter/material.dart';

class HCard extends StatelessWidget {
  const HCard(
      {Key? key, required this.title, required this.color, required this.icon})
      : super(key: key);

  final String title;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100, maxWidth: 400),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: VerticalDivider(thickness: 0.8, width: 0),
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 35,
          )
        ],
      ),
    );
  }
}
