import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/widgets/prescriptions/customized_appbar_widget.dart';
import 'package:neurology_clinic/view/widgets/prescriptions/mediacation_card_widget.dart';

import '/controller/prescriptions/prescriptions_controller.dart';

class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

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
            child: CustomizedAppbarWidget(
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
                                return MedicationCardWidget(
                                  isAll: false,
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

