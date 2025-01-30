import '/view/widget/language/custom_button_language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLanguage extends StatelessWidget {
  const AppLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "1".tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const CustomButtonLanguage(
              language: "عربي",
              languageCode: "ar",
            ),
            const CustomButtonLanguage(
              language: "English",
              languageCode: "en",
            ),
          ],
        ),
      ),
    );
  }
}
