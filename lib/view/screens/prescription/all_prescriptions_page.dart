import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/prescriptions/all_prescriptions_controller.dart';
import 'package:neurology_clinic/view/widgets/prescriptions/mediacation_card_widget.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<AllPrescriptionsController>(
              builder: (controller) {
                return EasyDateTimeLinePicker(
                  controller: controller.dateController,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026, 3, 18),
                  locale: Get.locale,
                  // locale: controller.initialLang,
                  focusedDate: controller.selectedDate,
                  onDateChange: (selectedDate) {
                    controller.onDateChange(selectedDate);
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Text(
                "medications".tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GetBuilder<AllPrescriptionsController>(
              builder: (controller) {
                if (controller.status == AllPrescriptionsStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.status == AllPrescriptionsStatus.success) {
                  if (controller.allPrescriptions.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text(
                          "لا يوجد لديك وصفات طبية",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        ...controller.allPrescriptions.map((prescription) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MedicationCardWidget(
                              isAll: true,
                              size: size,
                              prescription: prescription,
                              instructions: 'instructions'.tr,
                            ),
                          );
                        }).toList()
                      ],
                    );
                  }
                }
                return Text("something went wrong");
              },
            )
          ],
        ),
      ),
    );
  }
}
