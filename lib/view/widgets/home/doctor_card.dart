import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/services.dart';
import '/core/layouts/app_color_theme.dart';
import '../../../app_theme.dart';
import '../../../core/constants/app_route_name.dart';
import '../../screens/doctor_details/doctor_details.dart';

class DoctorsCard extends StatelessWidget {
  DoctorsCard({
    super.key,
    required this.scrollDirection,
  });
  final MyServices myServices = Get.find<MyServices>();
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(() {
        if (myServices.loadingStates['doctorLoading'] == true ||
            myServices.doctors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
          // } else if (controller.errorMessage.isNotEmpty) {
          //   return const Center(child: Text('لست متصلاً بالانترنت'));
        } else {
          var doctors = myServices.doctors;
          return ListView.builder(
              itemCount: doctors.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                doctors[index];
                return TextButton(
                    onPressed: () {
                      Get.toNamed(AppRouteName.doctorDetails,
                          arguments: {'doctor': doctors[index]});
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
                              profileImage: doctors[index].profileImage,
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
                                    'الدكتور: ${doctors[index].name}',
                                    style: themeArabic.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    doctors[index].specialization,
                                    style: themeArabic.textTheme.bodyLarge,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(AppRouteName.doctorDetails,
                                            arguments: {
                                              'doctor': doctors[index]
                                            });
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
