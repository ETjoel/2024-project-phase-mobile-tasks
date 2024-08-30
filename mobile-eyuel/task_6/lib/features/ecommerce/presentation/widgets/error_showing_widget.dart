import 'package:flutter/material.dart';

class ErrorShow extends StatelessWidget {
  final String message;
  const ErrorShow({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key('ERROR_SHOW'),
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        )),
      ),
    );
  }
}
