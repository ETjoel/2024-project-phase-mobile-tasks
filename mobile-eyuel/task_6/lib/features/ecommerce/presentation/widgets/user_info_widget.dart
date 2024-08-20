import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade400),
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('July 14, 2023',
                style: TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            Row(
              children: [
                Text(
                  'Hello',
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                Text('Yohannes',
                    style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ],
    );
  }
}
