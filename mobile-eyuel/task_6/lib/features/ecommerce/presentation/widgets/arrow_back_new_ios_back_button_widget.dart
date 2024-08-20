import 'package:flutter/material.dart';

class ArrowNewIosBackButton extends StatelessWidget {
  const ArrowNewIosBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new,
            color: Color.fromRGBO(63, 81, 243, 1)));
  }
}
