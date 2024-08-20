import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final Function onSubmitted;

  const SearchTextField({
    super.key,
    required this.nameController,
    required this.onSubmitted,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 40,
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.arrow_forward_sharp,
              color: Color.fromRGBO(63, 81, 243, 1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSubmitted: (value) => onSubmitted,
      ),
    );
  }
}
