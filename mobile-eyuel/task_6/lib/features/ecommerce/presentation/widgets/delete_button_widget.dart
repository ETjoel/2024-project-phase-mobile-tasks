import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  const DeleteButton({
    super.key,
    this.width = double.infinity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.redAccent)),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.redAccent, fontSize: 20),
          ),
        ));
  }
}
