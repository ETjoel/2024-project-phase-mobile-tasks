import 'package:flutter/material.dart';

import 'widgets.dart';

class ChatUser extends StatefulWidget {
  const ChatUser({super.key});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.height * 0.02),
      child: Row(
        children: [
          Badge(
            alignment: Alignment(0.75, 0.9),
            // label: Text('2'),
            backgroundColor: Colors.green,
            child: UserImage(
              size: 60,
              imageUrl: 'imageUrl',
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: Text('name',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  'last message is the best thing in here and i want to mention that bible is the best book of the year',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: 'Sora',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Spacer(),
          Badge(
            alignment: Alignment.bottomRight,
            backgroundColor: Colors.purple,
            child: Column(
              children: [
                Text('2:49 PM',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'Sora',
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 30),
              ],
            ),
            label: Text('2'),
          ),
        ],
      ),
    );
  }
}
