import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/home_controller/home_controller.dart';
import '/core/layouts/app_color_theme.dart';
import '../../../app_theme.dart';
import '../../../core/constants/app_route_name.dart';
import '../../../data/datasource/model/doctor_model.dart';
import '../../screens/doctor_details/doctor_details.dart';

class DoctorsCard extends StatelessWidget {
  final HomeController controller;

  const DoctorsCard({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(() {
        if (controller.loadingStates['bookingloading'] == true ||
            controller.doctors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
          // } else if (controller.errorMessage.isNotEmpty) {
          //   return const Center(child: Text('لست متصلاً بالانترنت'));
        } else {
          return ListView.builder(
              itemCount: controller.doctors.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Doctor doctor = controller.doctors[index];
                return TextButton(
                    onPressed: () {
                      Get.toNamed(AppRouteName.doctorDetails,
                          arguments: {'doctor': doctor});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(maxWidth: 350, maxHeight: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [
                              AppColorTheme.background3,
                              AppColorTheme.background3.withValues(alpha: 0.5)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                            color: AppColorTheme.background3
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 12),
                          ),
                          BoxShadow(
                            color: AppColorTheme.background3
                                .withValues(alpha: 0.3),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileImageWidget(
                              borderRadius: 10,
                              profileImage: doctor.profileImage,
                              height: 200,
                              fit: BoxFit.fitHeight),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: AppColorTheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'الدكتور: ${doctor.name}',
                                    style: themeArabic.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    doctor.specialization,
                                    style: themeArabic.textTheme.bodyLarge,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(AppRouteName.doctorDetails,
                                            arguments: {'doctor': doctor});
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: AppColorTheme.background3,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Text(
                                          'طلب موعد',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColorTheme.background,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        }
      }),
    );
  }
}
