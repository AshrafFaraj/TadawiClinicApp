import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/controller/appointment/appointments_controller.dart';
import 'package:neurology_clinic/core/constants/app_route_name.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_svg.dart';
import '../../../core/layouts/app_layout.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "appo".tr, fontWeight: FontWeight.w600),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(
              text: "upc".tr,
            ),
            Tab(
              text: "pa".tr,
            )
          ],
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          EmptyAppointmentsWidget(
            size: size,
            text: "booktext".tr,
            assetName: AppSvg.doctorsSvg,
            width: 300,
            onPressed: () {
              // localController.changeLang("ar");1111
            },
          ),
          // Column(
          //   children: [
          //     Container(
          //       width: size.width,
          //       height: size.height * .27,
          //       margin: EdgeInsets.all(10),
          //       padding: EdgeInsets.all(18.0),

          //       decoration: BoxDecoration(
          //         color: color.onPrimary,
          //         borderRadius: BorderRadius.circular(15), // Rounded corners
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black
          //                 .withOpacity(0.2), // Shadow color with opacity
          //             spreadRadius: 2, // How wide the shadow spreads
          //             blurRadius: 10, // How soft the shadow looks
          //             offset: Offset(4, 4), // X and Y offset of the shadow
          //           ),
          //         ],
          //       ),
          //       // color: Colors.red,
          //       child: Column(
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(5),
          //             margin: EdgeInsets.all(1),
          //             height: 50,
          //             decoration: BoxDecoration(
          //                 color: Colors.grey.shade300,
          //                 borderRadius: BorderRadius.circular(5)),
          //             child: Row(
          //               children: [
          //                 CircleAvatar(
          //                   child: ClipOval(
          //                     child: Image.asset(
          //                       AppImages.doctor,
          //                       width: 100,
          //                       height: 100,
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 Column(
          //                   children: [
          //                     Text("Dr.Strange"),
          //                     textWidget(
          //                         text: "Heart", fontWeight: FontWeight.w300)
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Row(
          //                 children: [
          //                   SvgPicture.asset(
          //                     AppSvg.calendar,
          //                     colorFilter: ColorFilter.mode(
          //                         Colors.black, BlendMode.srcIn),
          //                   ),
          //                   SizedBox(
          //                     width: 5,
          //                   ),
          //                   textWidget(
          //                       text: "8:20 am", fontWeight: FontWeight.w300)
          //                 ],
          //               ),
          //               Row(
          //                 children: [
          //                   SvgPicture.asset(
          //                     AppSvg.clock,
          //                   ),
          //                   SizedBox(
          //                     width: 5,
          //                   ),
          //                   textWidget(
          //                       text: "14/1/2025", fontWeight: FontWeight.w300)
          //                 ],
          //               ),
          //             ],
          //           ),
          //           Divider(
          //             color: Colors.black,
          //             thickness: 0.2,
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               ElevatedButton(
          //                 onPressed: () {},
          //                 child: textWidget(
          //                     text: "Reshedule", textColor: color.onPrimary),
          //                 style: ElevatedButton.styleFrom(
          //                     fixedSize:
          //                         Size(size.width * .4, size.height * .01),
          //                     backgroundColor: color.primary),
          //               ),
          //               OutlinedButton(
          //                 onPressed: () {},
          //                 child: Text("Cancel"),
          //                 style: OutlinedButton.styleFrom(
          //                   fixedSize: Size(size.width * .4, size.height * .01),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          EmptyAppointmentsWidget(
            size: size,
            text: "booktext".tr,
            assetName: AppSvg.history,
            width: 215,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRouteName.bookAppointmentPage);
        },
        child: Icon(Icons.add_outlined),
      ),
    );
  }
}

class EmptyAppointmentsWidget extends StatelessWidget {
  const EmptyAppointmentsWidget({
    super.key,
    required this.size,
    required this.text,
    required this.assetName,
    required this.width,
    this.onPressed,
  });
  final Size size;
  final String text;
  final String assetName;
  final double width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .1,
          ),
          SvgPicture.asset(
            assetName,
            width: width,
          ),
          SizedBox(
            height: size.height * .09,
          ),
          textWidget(text: text, textColor: Colors.grey, fontSize: 15),
          SizedBox(height: 20),
          OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                fixedSize: Size(size.width * 0.8, size.height * .07),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Makes the button square
                ),
                side: BorderSide(
                    color: Colors.blue,
                    width: 0.9), // Customize the border color
              ),
              child: textWidget(
                  text: "bookbutton".tr,
                  textColor: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15))
        ],
      ),
    );
  }
}
