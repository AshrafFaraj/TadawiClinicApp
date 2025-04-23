import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neurology_clinic/controller/doctor_controller.dart';
import 'package:neurology_clinic/core/functions/format_time_finction.dart';
import 'package:neurology_clinic/core/layouts/app_color_theme.dart';
import 'package:neurology_clinic/data/datasource/model/doctor_model.dart';
import 'package:neurology_clinic/data/datasource/model/doctor_schedule.dart';

import '../core/constants/app_route_name.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.put(DoctorController());
    return Scaffold(
        appBar: AppBar(
          title: Text("الأطباء"),
        ),
        body: GetBuilder<DoctorController>(
          builder: (controller) {
            if (controller.isLoading) {
              return Center(child: Lottie.asset('assets/lottie/ECG.json'));
            } else if (controller.doctors.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withValues(alpha: 0.2), // Shadow color with opacity
                      spreadRadius: 2, // How wide the shadow spreads
                      blurRadius: 10, // How soft the shadow looks
                      offset:
                          const Offset(4, 4), // X and Y offset of the shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/no_connect.json',
                        height: 100, width: 100, fit: BoxFit.fill),
                    const Text(
                      'لا يوجد أطباء حالياً أو لا يوجد اتصال',
                      style: TextStyle(color: AppColorTheme.card),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...controller.doctors.map((doctor) {
                    return DoctorsContainer(
                      size: size,
                      doctor: doctor,
                      onTap: () async {
                        final result = await Get.toNamed(
                            AppRouteName.doctorDetails,
                            arguments: {'doctor': doctor});

                        if (result != null) {
                          Get.back(result: "success");
                        }
                      },
                    );
                  })
                ],
              ),
            );
          },
        ));
  }
}

class DoctorsContainer extends StatelessWidget {
  const DoctorsContainer({
    super.key,
    required this.size,
    required this.doctor,
    this.onTap,
    // required this.doctor,
  });
  final Doctor doctor;

  final Size size;
  final void Function()? onTap;
  // final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final todaysSchedule = doctor.getTodaysSchedule();
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        width: size.width,
        // height: size.height * .12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color with opacity
              spreadRadius: 1, // How wide the shadow spreads
              blurRadius: 1, // How soft the shadow looks
              // offset: Offset(1, 1), // X and Y offset of the shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/doctor_pic2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  doctor.specialization,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                    // fontWeight: FontWeight.w100
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    todaysSchedule.isNotEmpty
                        ? TimesWidget(
                            doctorSchedule: doctor.getSchedule()[0],
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 10,
                    ),
                    todaysSchedule.length > 1
                        ? TimesWidget(
                            doctorSchedule: doctor.getSchedule()[1],
                          )
                        : SizedBox()
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TimesWidget extends StatelessWidget {
  const TimesWidget({
    super.key,
    required this.doctorSchedule,
  });
  final DoctorSchedule doctorSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFE0E7FF),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        textDirection: TextDirection.ltr,
        "${formatTime(doctorSchedule.startTime)} -${formatTime(doctorSchedule.endTime)} ",
        style: TextStyle(color: Colors.blue, fontSize: 10),
      ),
    );
  }
}
