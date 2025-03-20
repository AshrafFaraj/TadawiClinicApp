import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '/controller/ai_chat/ai_chat_controller.dart';
import '/core/constants/app_lottie.dart';
import '/core/constants/app_svg.dart';
import '/locale/local_controller.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    LocalController localController = Get.find();
    Get.put(AiChatController());

    return Scaffold(
        appBar: AppBar(
          title: Text("chatpage".tr),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GetBuilder<AiChatController>(
          builder: (controller) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                children: [
                  controller.messages.isEmpty
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "wt".tr,
                                  style: text.headlineSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Tips(
                                      onTap: () {
                                        localController.changeLang("ar");
                                      },
                                      textTheme: text,
                                      text: "medidea".tr,
                                      svg: AppSvg.idea,
                                    ),
                                    const SizedBox(width: 5),
                                    Tips(
                                      onTap: () {
                                        localController.changeLang("en");
                                      },
                                      textTheme: text,
                                      text: "medadvice".tr,
                                      svg: AppSvg.help,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.messages.length +
                                (controller.isLoading ? 1 : 0),
                            reverse: true,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              if (controller.isLoading && index == 0) {
                                // Show Lottie animation for loading
                                return Align(
                                  alignment: Get.locale!.languageCode == "en"
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Lottie.asset(
                                    AppLottie
                                        .generating, // Replace with your Lottie file
                                    width: 50,
                                    height: 50,
                                  ),
                                );
                              }

                              final message = controller.messages[
                                  controller.messages.length -
                                      1 -
                                      (index - (controller.isLoading ? 1 : 0))];
                              final isUser = message["sender"] == "user";

                              return Align(
                                alignment: isUser
                                    ? Get.locale!.languageCode == "en"
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft
                                    : Get.locale!.languageCode == "en"
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? color.primaryContainer
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    message["text"]!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.center,
                              height: size.height * .07,
                              decoration: BoxDecoration(
                                color: color.secondaryContainer,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  hintText: "typemessege".tr,
                                  hintStyle: TextStyle(
                                      color: color.onSecondaryContainer),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: size.height * .09,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                AppSvg.send,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                              onPressed: () {
                                controller
                                    .sendMesseges(_messageController.text);
                                _messageController.clear();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class Tips extends StatelessWidget {
  const Tips({
    super.key,
    required this.textTheme,
    required this.text,
    required this.svg,
    this.onTap,
  });

  final TextTheme textTheme;
  final String text;
  final String svg;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            SvgPicture.asset(
              svg,
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style:
                  textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
