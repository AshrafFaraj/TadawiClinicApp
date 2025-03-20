import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neurology_clinic/core/constants/app_lottie.dart';

import '../../../controller/ai_chat/ai_chat_controller.dart';
import '../../../core/constants/app_svg.dart';
import '../../../locale/local_controller.dart';

class AiPage extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController =
      ScrollController(); // Add Scroll Controller

  AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(AiController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("wt".tr),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: GetBuilder<AiController>(
            builder: (controller) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                }
              });

              return ListView.builder(
                controller: scrollController, // Attach scroll controller
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  var msg = chatController.messages[index];
                  return MessageBubble(
                    msg: msg,
                    size: size,
                  );
                },
              );
            },
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomizedTextField(
              hintText: "typemessege".tr,
              controller: messageController,
              onPressed: () {
                if (chatController.isGenerating) {
                  chatController
                      .stopGenerating(); // Stop the generation if it is ongoing
                } else {
                  chatController
                      .sendMessage(messageController.text); // Send the message
                  messageController.clear();
                }
              },
              icon: GetBuilder<AiController>(
                builder: (controller) {
                  return controller.isGenerating
                      ? const Icon(
                          Icons.stop,
                          color: Colors.white,
                        )
                      : SvgPicture.asset(
                          AppSvg.send,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> msg;
  final Size size;

  const MessageBubble({super.key, required this.msg, required this.size});

  @override
  Widget build(BuildContext context) {
    bool isUser = msg["sender"] == "user";
    bool isTyping = msg["loading"] ?? false;
    bool isArabic = Get.locale?.languageCode == "ar";

    return Align(
      alignment: isUser
          ? (isArabic ? Alignment.centerLeft : Alignment.centerRight)
          : (isArabic ? Alignment.centerRight : Alignment.centerLeft),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // width: size.width * 0.7,
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: isUser ? (isArabic ? 10 : 120) : 10,
          right: isUser ? (isArabic ? 120 : 10) : (isArabic ? 20 : 50),
        ),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF201D67) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(!isUser ? (isArabic ? 8 : 20) : 20),
            topLeft: Radius.circular(!isUser ? (isArabic ? 20 : 8) : 20),
            bottomLeft: Radius.circular(isUser ? (isArabic ? 8 : 20) : 20),
            bottomRight: Radius.circular(isUser ? (isArabic ? 20 : 8) : 20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isTyping)
              SizedBox(
                width: 30,
                child: Lottie.asset(
                  AppLottie.generating, // Replace with your Lottie file
                  // width: 50,
                  // height: 50,
                ),
              ),
            if (!isTyping)
              Flexible(
                child: Text(
                  msg["text"]!,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black,
                    fontSize: 15,
                    // fontFamily: "monospace",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomizedTextField extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController? controller;
  final String hintText;
  final Widget icon;

  const CustomizedTextField({
    super.key,
    this.onPressed,
    this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText, // Localized text
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF201D67),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(onPressed: onPressed, icon: icon),
          ),
        ],
      ),
    );
  }
}
