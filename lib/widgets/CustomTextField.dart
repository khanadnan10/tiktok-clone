import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isObscure,
      validator: (value) {
        if (value == null && value!.isEmpty) {
          return 'Enter all fields';
        }
      },
    );
  }
}
