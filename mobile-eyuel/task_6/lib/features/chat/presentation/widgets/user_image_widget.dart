import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final double size;
  final String imageUrl;
  const UserImage({
    super.key,
    required this.size,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 2),
            color: Colors.grey.shade400),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
            'images/DMX holding a sign quoted \'Y\'all gon\' make me lose my mind\' anime style cinematic.png'));
  }
}
