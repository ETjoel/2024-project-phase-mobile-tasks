import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController descriptionTextField;

  const DescriptionTextField({
    required this.descriptionTextField,
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
        controller: descriptionTextField,
        minLines: 5,
        maxLines: 10,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
