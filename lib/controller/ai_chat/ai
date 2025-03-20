import 'package:get/get.dart';

class AiChatController extends GetxController {
  final List<Map<String, String>> messages = [];
  bool isLoading = false;
  void sendMesseges(String text) {
    if (text.trim().isNotEmpty) {
      messages.add({"sender": "user", "text": text.trim()});
      isLoading = true; // Start loading
      update();
      // Simulate AI Response
      Future.delayed(Duration(milliseconds: 1500), () {
        isLoading = false; // Stop loading
        messages.add({"sender": "bot", "text": "This is an AI response."});
      update();
      });
    }
  }
}
