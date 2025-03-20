import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiController extends GetxController {
  final String apiKey = "AIzaSyAde9vzxwbM616UGBzB7O7-TeQrctuOtVc"; 
  final String baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  List<Map<String, dynamic>> messages = []; // Non-reactive list
  bool isGenerating = false; // Non-reactive flag

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.isEmpty || isGenerating) return;

    isGenerating = true;
    update(); // Notify UI about isGenerating change

    // Add user message
    messages.add({"sender": "user", "text": userMessage});

    // Add empty bot message
    var botMessage = {"sender": "bot", "text": "", "loading": true};
    messages.add(botMessage);

    try {
      final Uri uri = Uri.parse("$baseUrl?key=$apiKey");

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userMessage}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String botResponse = responseData['candidates'][0]['content']['parts'][0]['text'];

        // Remove loading message
        messages.removeLast();
        messages.add({"sender": "bot", "text": "", "loading": false});

        // Typing effect (step-by-step generation)
        for (int i = 0; i < botResponse.length; i++) {
          if (!isGenerating) break; // Stop when user clicks "Stop Generating"

          await Future.delayed(const Duration(milliseconds: 30));
          messages.last["text"] = botResponse.substring(0, i + 1);
          update(); // Notify UI after each new character
        }
      } else {
        messages.removeLast();
        messages.add({"sender": "bot", "text": "Error: Unable to fetch response", "loading": false});
      }
    } catch (e) {
      messages.removeLast();
      messages.add({"sender": "bot", "text": "Error: ${e.toString()}", "loading": false});
    } finally {
      isGenerating = false;
      update(); // Notify UI after generation is complete
    }
  }

  void stopGenerating() {
    isGenerating = false;
    update(); // Notify UI that generation stopped
  }
}
