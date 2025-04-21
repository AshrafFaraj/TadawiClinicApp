import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_route_name.dart';
import '../../../data/datasource/model/doctor_model.dart';
import '/app_theme.dart';
import '../../../core/layouts/app_color_theme.dart';

// ignore: must_be_immutable
class DoctorDetails extends StatelessWidget {
  DoctorDetails({super.key});

  Doctor doctor = Get.arguments['doctor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الدكتور: ${doctor.name}',
                    style: themeArabic.textTheme.headlineSmall),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ProfileImageWidget(
                        profileImage: doctor.profileImage,
                        fit: BoxFit.cover,
                        height: 180,
                        width: 160,
                        borderRadius: 10,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'أخصائي: ${doctor.specialization}',
                            style: themeArabic.textTheme.bodyLarge,
                          ),
                          Text('الخبرة: ${doctor.experienceYears} سنوات',
                              style: themeArabic.textTheme.bodyLarge),
                          Text('موبايل: ${doctor.mobile}',
                              style: themeArabic.textTheme.bodyLarge),
                          Text('الثابت: ${doctor.landlinePhone}',
                              style: themeArabic.textTheme.bodyLarge),
                          Text('متاح: ${doctor.isAvailable ? "نعم" : "لا"}',
                              style: themeArabic.textTheme.bodyLarge),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: doctor.detectionPrice != null
                                  ? Text(
                                      'سعر الكشف: ${doctor.detectionPrice} ريال',
                                      style: themeArabic.textTheme.bodyLarge)
                                  : const Text(
                                      'غير محدد',
                                      style: TextStyle(
                                          color: AppColorTheme.card,
                                          fontSize: 15),
                                    ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                Text(
                  "نبذة عن الطبيب",
                  style: themeArabic.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  doctor.about,
                  style: themeArabic.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/mappin.png"),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("العنوان",
                                    style: themeArabic.textTheme.headlineSmall),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 268,
                                    child: Text(
                                      doctor.address,
                                      style: themeArabic.textTheme.bodyLarge,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/map.png",
                      width: 180,
                    )
                  ],
                ),
                Text("أوقات الدوام",
                    style: themeArabic.textTheme.headlineSmall),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  height: 160,
                  child: doctor.schedules.isNotEmpty
                      ? ListView.builder(
                          itemCount: doctor.schedules.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: AppColorTheme.background3,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Text(
                                    doctor.schedules[index].day,
                                    style: themeArabic.textTheme.headlineSmall,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 180,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColorTheme.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'بداية الدوام ${doctor.schedules[index].startTime}',
                                          style:
                                              themeArabic.textTheme.bodyLarge,
                                        ),
                                        Text(
                                            'نهاية الدوام ${doctor.schedules[index].startTime}',
                                            style: themeArabic
                                                .textTheme.bodyLarge),
                                      ],
                                    ),
                                  )
                                ],
                              )))
                      : Center(
                          child: Text(
                          'عذراً : لم يتم اضافة اوقات الدوام',
                          style: themeArabic.textTheme.bodyLarge,
                        )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        final result = await Get.toNamed(
                            AppRouteName.bookAppointmentPage,
                            arguments: {
                              'action': 'new',
                              'doctorId': doctor.id
                            });

                        if (result != null) {
                          Get.back(result: "success");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // Makes the button square
                        ),
                      ),
                      child: Text(
                        "setappointment".tr,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}

class ProfileImageWidget extends StatelessWidget {
  final String? profileImage;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;

  const ProfileImageWidget({
    super.key,
    required this.profileImage,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.borderRadius = 100, // دائري بشكل افتراضي
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = (profileImage != null && profileImage!.isNotEmpty)
        ? NetworkImage(profileImage!)
        : const AssetImage('assets/doctor.jpg') as ImageProvider;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image(
        image: imageProvider,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/doctor.jpg',
            width: width,
            height: height,
            fit: fit,
          );
        },
      ),
    );
  }
}
