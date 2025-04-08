import 'package:flutter/material.dart';

import '../../../core/constants/app_svg.dart';
import '../../../core/layouts/app_layout.dart';
import '../../../data/datasource/model/booking_model.dart';
import 'time_elements_widget.dart';

class AppointmentCardWidget extends StatelessWidget {
  const AppointmentCardWidget({
    super.key,
    required this.size,
    required this.color,
    required this.appointment,
    this.onElevatedPressed,
    this.onOutlinedPressed,
    required this.buttonText,
    required this.status,
    required this.outlinedText,
  });
  final Appointment appointment;

  final Size size;
  final ColorScheme color;
  final void Function()? onElevatedPressed;
  final void Function()? onOutlinedPressed;
  final String buttonText;
  final String status;
  final String outlinedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * .29,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(18.0),

      decoration: BoxDecoration(
        color: color.onPrimary,
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 2, // How wide the shadow spreads
            blurRadius: 10, // How soft the shadow looks
            offset: Offset(4, 4), // X and Y offset of the shadow
          ),
        ],
      ),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // width: size.width * .3,
                height: size.height * .06,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${appointment.doctorName}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    // textWidget(
                    //     text: "${booking.doctor!.specialization}",
                    //     fontWeight: FontWeight.w500,
                    //     textColor: Colors.black,
                    //     fontSize: 14),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * .3,
                height: size.height * .05,
                decoration: BoxDecoration(
                    color: color.secondaryContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color.onSecondaryContainer,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            height: size.height * .06,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeElementsWidgets(
                  size: size,
                  text: "8:20 am",
                  svg: AppSvg.calendar,
                ),
                TimeElementsWidgets(
                  size: size,
                  text: "${appointment.date}",
                  svg: AppSvg.clock,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onElevatedPressed,
                child:
                    textWidget(text: outlinedText, textColor: color.onPrimary),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * .4, size.height * .01),
                    backgroundColor: color.primary),
              ),
              OutlinedButton(
                onPressed: onOutlinedPressed,
                child: Text(buttonText),
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(size.width * .4, size.height * .01),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
