import 'package:flutter/material.dart';

class PriceTextField extends StatelessWidget {
  const PriceTextField({
    super.key,
    required this.priceController,
  });

  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: priceController,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
