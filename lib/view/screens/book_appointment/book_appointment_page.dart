import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/layouts/app_layout.dart';
import 'examples/simple_use_date_picker.dart';

class BookAppointmentPage extends StatelessWidget {
  BookAppointmentPage({Key? key}) : super(key: key);

  // final BookAppointmentController controller =
  //     Get.find<BookAppointmentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "bookbutton".tr, fontWeight: FontWeight.w600),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SimpleUseExample(),
    );
  }
}
