import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../auth/domain/entities/user.dart';
import '../widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final UserEntity user;
  const ChatPage({required this.user, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: primaryColor,
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserInfo(name: widget.user.name, members: 8, onlines: 5),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.videocam_outlined)),
          ],
        ),
        bottomNavigationBar: const BottomChatBar(),
        body: const ListOfMessages());
  }
}

class UserInfo extends StatelessWidget {
  final String name;
  final int onlines, members;
  const UserInfo({
    super.key,
    required this.name,
    required this.onlines,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: UserImage(
            size: 50,
            imageUrl: 'someimage',
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
              '$members members, $onlines onlines',
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: 'Sora',
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ],
    );
  }
}

class ListOfMessages extends StatelessWidget {
  const ListOfMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: 1,
          reverse: true,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(15.0),
              child: NotChatroomOwner(
                  imageUrl: 'someImage',
                  message: 'It will be showed here!',
                  time: '2 : 49 PM'),
            );
          }),
    );
  }
}
