import 'package:neurology_clinic/controller/signup_data_controller.dart';
import 'package:neurology_clinic/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestVeiw extends StatelessWidget {
  const TestVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('test data'),
        ),
        body: GetBuilder<TestController>(
          builder: (controller) => controller.statusRequest ==
                  StatusRequest.loading
              ? Center(
                  child: Text("loading"),
                )
              : (controller.statusRequest == StatusRequest.offllineFailure)
                  ? Center(
                      child: Text("offline server"),
                    )
                  : (controller.statusRequest == StatusRequest.serverFailure)
                      ? Center(
                          child: Text("server failure"),
                        )
                      : ListView.builder(
                          itemCount: controller.data.length,
                          itemBuilder: (context, i) {
                            return Text("${controller.data}");
                          },
                        ),
        ));
  }
}
