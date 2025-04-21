import 'package:flutter/material.dart';

import '../../../data/datasource/model/appointment_model.dart';
import '../../../data/datasource/model/booking_model.dart';

class CustomizedAppbarWidget extends StatelessWidget {
  const CustomizedAppbarWidget({
    super.key,
    required this.size,
    this.onPressed,
    required this.appointment,
    required this.appBarText,
  });

  final Size size;
  final void Function()? onPressed;
  final Appointment appointment;
  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * .25,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      decoration: BoxDecoration(color: const Color(0xFF312E81)),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                appBarText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appointment.doctorName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                appointment.date,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
