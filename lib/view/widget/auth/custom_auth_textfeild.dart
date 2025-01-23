import 'package:flutter/material.dart';

class CustomTextFormFeildAuth extends StatelessWidget {
  const CustomTextFormFeildAuth(
      {super.key,
      this.label = "",
      this.isNumber = false,
      this.isObscure = false,
      required this.suffixIcon,
      required this.hintText,
      this.mycontroller,
      this.validator});
  final String label;
  final Widget suffixIcon;
  final String hintText;
  final TextEditingController? mycontroller;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        obscureText: isObscure,
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: validator,
        controller: mycontroller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          label: label != ""
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(label),
                )
              : null,
          hintStyle: const TextStyle(fontSize: 12),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
