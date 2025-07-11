import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/controller/doctor_controller.dart';
import '../../../services/services.dart';
import '/core/layouts/app_color_theme.dart';
import '../../../app_theme.dart';
import '../../../core/constants/app_route_name.dart';
import '../../screens/doctor_details/doctor_details.dart';

class DoctorsCard extends StatelessWidget {
  DoctorsCard({super.key, required this.scrollDirection});
  final MyServices myServices = Get.find<MyServices>();
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    Get.put(DoctorController());
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GetBuilder<DoctorController>(builder: (controller) {
        return Skeletonizer(
            enabled: controller.isLoading,
            child: (controller.doctors.isEmpty)
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    constraints:
                        const BoxConstraints(maxWidth: 360, maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                              alpha: 0.1), // Shadow color with opacity
                          spreadRadius: 1, // How wide the shadow spreads
                          blurRadius: 10, // How soft the shadow looks
                          offset: const Offset(
                              0, 0), // X and Y offset of the shadow
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
                    ))
                : ListView.builder(
                    itemCount: controller.doctors.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          Get.toNamed(AppRouteName.doctorDetails,
                              arguments: {'doctor': controller.doctors[index]});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              maxWidth: 350, maxHeight: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColorTheme.background,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                    alpha: 0.1), // Shadow color with opacity
                                spreadRadius: 1, // How wide the shadow spreads
                                blurRadius: 10, // How soft the shadow looks
                                offset: const Offset(
                                    0, 0), // X and Y offset of the shadow
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileImageWidget(
                                borderRadius: 50,
                                profileImage:
                                    controller.doctors[index].profileImage,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    color: AppColorTheme.lightGray,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'الدكتور: ${controller.doctors[index].name}',
                                        style: themeArabic.textTheme.bodyLarge,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'أخصائي: ${controller.doctors[index].specialization}',
                                        style: const TextStyle(
                                            color: AppColorTheme.card,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              AppRouteName.doctorDetails,
                                              arguments: {
                                                'doctor':
                                                    controller.doctors[index]
                                              });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppColorTheme.background3,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Text(
                                            'طلب موعد',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColorTheme.background,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
      }),
    );
  }
}
