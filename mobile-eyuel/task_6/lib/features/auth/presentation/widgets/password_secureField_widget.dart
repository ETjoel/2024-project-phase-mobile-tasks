import 'package:flutter/material.dart';

class PasswordSecureFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  const PasswordSecureFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: 'password',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none),
        ));
  }
}
