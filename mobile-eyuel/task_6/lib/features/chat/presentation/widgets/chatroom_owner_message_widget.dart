import 'package:flutter/material.dart';

import 'widgets.dart';

class ChatroomOwner extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String time;

  const ChatroomOwner(
      {super.key,
      required this.imageUrl,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('you'),
            const SizedBox(width: 3),
            UserImage(size: 40, imageUrl: imageUrl)
          ],
        ),
        Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(time,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
        )
      ],
    );
  }
}
