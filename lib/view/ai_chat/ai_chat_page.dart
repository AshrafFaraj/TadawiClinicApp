import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/app_lottie.dart';
import '../../core/constants/app_svg.dart';
import '../../locale/local_controller.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages
            .add({"sender": "user", "text": _messageController.text.trim()});
        _isLoading = true; // Start loading
      });
      _messageController.clear();

      // Simulate AI Response
      Future.delayed(Duration(milliseconds: 1500), () {
        setState(() {
          _isLoading = false; // Stop loading
          _messages.add({"sender": "bot", "text": "This is an AI response."});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    LocalController localController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text("chatpage".tr),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          _messages.isEmpty
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
                        SizedBox(height: 20),
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
                            SizedBox(width: 5),
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
                    itemCount: _messages.length + (_isLoading ? 1 : 0),
                    reverse: true,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      if (_isLoading && index == 0) {
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

                      final message = _messages[_messages.length -
                          1 -
                          (index - (_isLoading ? 1 : 0))];
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
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? color.primaryContainer
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message["text"]!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              width: size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                          hintStyle:
                              TextStyle(color: color.onSecondaryContainer),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: size.height * .09,
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppSvg.send,
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
        padding: EdgeInsets.all(10),
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
            SizedBox(
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
