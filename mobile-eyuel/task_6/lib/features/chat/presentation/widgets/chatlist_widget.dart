import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/chat_entity.dart';
import '../bloc/chat_bloc.dart';
import 'chat_user_widget.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({
    super.key,
    required this.chatList,
    required this.user,
  });

  final List<ChatEntity> chatList;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<ChatBloc>()
                      .add(GetChatMessagesEvent(chatId: chatList[index].id));
                  Navigator.pushNamed(context, '/chatroom', arguments: user);
                },
                child: ChatUser(
                    user: user.id != chatList[index].user2.id
                        ? chatList[index].user2
                        : chatList[index].user1),
              );
            }));
  }
}
