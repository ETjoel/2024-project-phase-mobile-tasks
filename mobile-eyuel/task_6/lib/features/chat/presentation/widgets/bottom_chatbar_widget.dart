import 'package:flutter/material.dart';

class BottomChatBar extends StatelessWidget {
  const BottomChatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 50,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Transform.rotate(
                  //
                  angle: 45,
                  child: const Icon(
                    Icons.attach_file,
                    textDirection: TextDirection.rtl,
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width / 1.9,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write your message',
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.photo_camera_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.mic_outlined)),
          ],
        ));
  }
}
