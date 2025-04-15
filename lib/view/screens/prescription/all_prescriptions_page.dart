import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/controller/prescriptions/prescriptions_controller.dart';
import '/core/constants/app_svg.dart';
import '/data/datasource/model/booking_model.dart';
import '/data/datasource/model/prescription_model.dart';

class AllPrescriptionsPage extends StatelessWidget {
  const AllPrescriptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(PrescriptionsController());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Prescription"),
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: CustomizedAppBar(
              appBarText: "prescriptions".tr,
              appointment: controller.appointment!,
              size: size,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Positioned(
            top: size.height * .19,
            child: Container(
              width: size.width,
              height: size.height * 0.81,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "medications".tr,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GetBuilder<PrescriptionsController>(
                      builder: (controller) {
                        if (controller.status == PrescriptionStatus.loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (controller.status == PrescriptionStatus.success) {
                          // return Expanded(
                          //   child: ListView.builder(
                          //     itemCount: controller.prescriptions.length,
                          //     itemBuilder: (context, index) {
                          //       return MedicationCard(
                          //           size: size,
                          //           prescription: controller.prescriptions[index]);
                          //     },
                          //   ),
                          // );
                          return Column(
                            children: [
                              ...controller.prescriptions.map((prescription) {
                                return MedicationCard(
                                  size: size,
                                  prescription: prescription,
                                  instructions: 'instructions'.tr,
                                );
                              }).toList()
                            ],
                          );
                        }
                        return Center(
                          child: Text("something went wrong"),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  const MedicationCard({
    super.key,
    required this.size,
    required this.prescription,
    required this.instructions,
  });

  final Size size;
  final Prescription prescription;
  final String instructions;

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
                )
              ],
            ),
          ),
          Wrap(
            runSpacing: 5.0,
            spacing: 5.0,
            children: [
              PrescriptionTakes(size: size, text: prescription.dosage!),
              PrescriptionTakes(size: size, text: prescription.duration!),
              PrescriptionTakes(size: size, text: prescription.time!),
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

class PrescriptionTakes extends StatelessWidget {
  const PrescriptionTakes({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size.width * .25,
      height: size.height * .05,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 226, 231, 246),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}

class CustomizedAppBar extends StatelessWidget {
  const CustomizedAppBar({
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
