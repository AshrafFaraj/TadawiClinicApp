import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/prescriptions/all_prescriptions_controller.dart';
import 'package:neurology_clinic/view/widgets/prescriptions/customized_appbar_widget.dart';
import 'package:neurology_clinic/view/widgets/prescriptions/mediacation_card_widget.dart';

import '/controller/prescriptions/prescriptions_controller.dart';

class AllPrescriptionsPage extends StatelessWidget {
  const AllPrescriptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.put(AllPrescriptionsController());
    return Scaffold(
      appBar: AppBar(
        title: Text("جميع الأدوية"),
      ),
      body: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   child: CustomizedAppbarWidget(
          //     appBarText: "prescriptions".tr,
          //     appointment: controller.appointment!,

          //     size: size,
          //     onPressed: () {
          //       Get.back();
          //     },
          //   ),
          // ),
          Container(
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
                  GetBuilder<AllPrescriptionsController>(
                    builder: (controller) {
                      if (controller.status == AllPrescriptionsStatus.loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (controller.status == AllPrescriptionsStatus.success) {
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
                            ...controller.allPrescriptions.map((prescription) {
                              return MedicationCardWidget(
                                isAll: true,
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
          )
        ],
      ),
    );
  }
}
