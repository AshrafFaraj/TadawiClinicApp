import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CustomOtpFeildAuth extends StatelessWidget {
  const CustomOtpFeildAuth({
    super.key,
    required this.onSubmit,
  });

  final void Function(String)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OtpTextField(
        autoFocus: true,
        numberOfFields: 5,
        keyboardType: TextInputType.number,
        fieldWidth: 50,
        borderRadius: BorderRadius.circular(20),
        borderColor: const Color.fromARGB(255, 231, 72, 4),
        showFieldAsBox: true,
        onCodeChanged: (String code) {},
        onSubmit: onSubmit,
      ),
    );
  }
}
