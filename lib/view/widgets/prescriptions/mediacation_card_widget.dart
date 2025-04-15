import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/widgets/prescriptions/prescriptions_take_widget.dart';

import '../../../core/constants/app_svg.dart';
import '../../../data/datasource/model/prescription_model.dart';

class MedicationCardWidget extends StatelessWidget {
  const MedicationCardWidget({
    super.key,
    required this.size,
    required this.prescription,
    required this.instructions, required this.isAll,
  });

  final Size size;
  final Prescription prescription;
  final String instructions;
  final bool isAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      // height: size.height * .27,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E7FF))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            height: size.height * .07,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: const Color(0xFFE0E7FF),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppSvg.pill,
                  width: 15,
                  height: 15,
                ),
                SizedBox(
                  width: 14,
                ),
                Text(
                  "${prescription.medicine!.name}",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  width: 155,
                ),
               isAll==true? Text(
                  "${prescription.bookingDate}",
                  style: TextStyle(color: Colors.black45, fontSize: 15),
                ):Text("")
              ],
            ),
          ),
          Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: [
              PrescriptionTakesWidget(size: size, text: prescription.dosage!),
              PrescriptionTakesWidget(size: size, text: prescription.duration!),
              PrescriptionTakesWidget(size: size, text: prescription.time!),
            ],
          ),
          Divider(
            color: const Color(0xFFE0E7FF),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              instructions,
              style: TextStyle(
                  fontSize: 15, color: Color.fromARGB(255, 130, 155, 237)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            child: Text(
              prescription.notes ?? "noInstructions".tr,
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
