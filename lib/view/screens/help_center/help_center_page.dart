import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("help_center".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "frequently_asked_questions".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildFAQTile("how_to_reset_password".tr,
                  "go_to_settings_and_click_reset_password".tr),
              _buildFAQTile("how_to_book_appointment".tr,
                  "go_to_appointments_and_select_available_slot".tr),
              _buildFAQTile("how_to_contact_support".tr,
                  "you_can_email_us_at_support@example.com".tr),
              SizedBox(height: 20),
              Text(
                "contact_support".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildSupportOption(Icons.chat, "live_chat".tr),
              _buildSupportOption(Icons.email, "email_support".tr),
              _buildSupportOption(Icons.call, "call_support".tr),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Text(question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(answer,
                style: TextStyle(fontSize: 14, color: Colors.black54)),
          )
        ],
      ),
    );
  }

  Widget _buildSupportOption(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text),
      onTap: () {
        // Implement navigation or functionality here
      },
    );
  }
}
