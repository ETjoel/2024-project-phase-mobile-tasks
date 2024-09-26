import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants.dart';

class EcomIconWidget extends StatelessWidget {
  final double width, height;
  const EcomIconWidget({super.key, this.width = 60, this.height = 20});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(height * 0.2),
      ),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        color: Colors.white,
        child: Text('ECOM',
            style: GoogleFonts.caveatBrush(
                fontSize: height * 0.8,
                color: primaryColor,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
