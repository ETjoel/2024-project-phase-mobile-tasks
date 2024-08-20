import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController nameController;

  const CustomTextField({
    required this.nameController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
