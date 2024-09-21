import 'package:flutter/material.dart';

import 'widgets.dart';

class NotChatroomOwner extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String time;
  const NotChatroomOwner(
      {super.key,
      required this.imageUrl,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserImage(size: 40, imageUrl: imageUrl),
            const SizedBox(width: 3),
            const Text('you'),
          ],
        ),
        Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            )),
        Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(time,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
        )
      ],
    );
  }
}
