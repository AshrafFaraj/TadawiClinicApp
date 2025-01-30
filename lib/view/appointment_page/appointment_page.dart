import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_svg.dart';
import '../../core/layouts/app_layout.dart';
import '../../locale/local_controller.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    LocalController localController = Get.find();
    // LocalController localController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "appo".tr, fontWeight: FontWeight.w600),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
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
        controller: _tabController,
        children: [
          // EmptyAppointmentsWidget(
          //   size: size,
          //   text: "booktext".tr,
          //   assetName: AppSvg.doctorsSvg,
          //   width: 300,
          //   onPressed: () {
          //     localController.changeLang("ar");
          //   },
          // ),
          ListView(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.27,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: color.onPrimary,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
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
                // color: Colors.red,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(1),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: ClipOval(
                              child: Image.asset(
                                AppImages.doctor,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              const Text("Dr.Strange"),
                              textWidget(
                                  text: "Heart", fontWeight: FontWeight.w300)
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.calendar,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            textWidget(
                                text: "8:20 am", fontWeight: FontWeight.w300)
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.clock,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            textWidget(
                                text: "14/1/2025", fontWeight: FontWeight.w300)
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(size.width * 0.4, size.height * 0.01),
                              backgroundColor: color.primary),
                          child: textWidget(
                              text: "Reshedule", textColor: color.onPrimary),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            fixedSize:
                                Size(size.width * 0.4, size.height * 0.01),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          EmptyAppointmentsWidget(
            size: size,
            text: "booktext".tr,
            assetName: AppSvg.history,
            width: 215,
            onPressed: () {
              localController.changeLang("en");
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/book");
        },
        child: const Icon(Icons.add_outlined),
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
            height: size.height * 0.1,
          ),
          SvgPicture.asset(
            assetName,
            width: width,
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
          textWidget(text: text, textColor: Colors.grey, fontSize: 15),
          const SizedBox(height: 20),
          OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                fixedSize: Size(size.width * 0.8, size.height * 0.07),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Makes the button square
                ),
                side: const BorderSide(
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
