import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../ecommerce/presentation/widgets/three_dot_waiting_widget.dart';
import '../../domain/entities/chat_entity.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chatlist_widget.dart';

class ChatListPage extends StatefulWidget {
  final UserEntity user;
  const ChatListPage({required this.user, super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  double _dragOffset = 0.0;
  List<ChatEntity> chatList = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: size.height * 0.02, left: size.width * 0.05),
                height: size.height,
                width: size.width,
                color: primaryColor,
                child: const Icon(Icons.search, size: 30)),
            Positioned(
              top: _dragOffset,
              left: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    if (_dragOffset < size.height * 0.1) {
                      _dragOffset += details.delta.dy;
                    } else {
                      _dragOffset += details.delta.dy * 0.05;
                    }
                    if (_dragOffset < 0) {
                      _dragOffset = 0.0;
                    }
                  });
                },
                onVerticalDragEnd: (details) {
                  if (_dragOffset < size.height * 0.1) {
                    setState(() {
                      _dragOffset = 0.0;
                    });
                  } else {
                    setState(() {
                      _dragOffset = size.height * 0.1;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  alignment: Alignment.center,
                  height: size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              min(_dragOffset * 0.7, size.height * 0.05)),
                          topRight: Radius.circular(
                              min(_dragOffset * 0.7, size.height * 0.05)))),
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 15,
                                color: primaryColor,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          Container(
                              height: 5,
                              width: 40,
                              color: Colors.grey.shade200),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ChatBloc, ChatState>(
                      builder: (context, state) {
                        if (state is ChatListLoading) {
                          return const Center(
                            child: ThreeDotWaiting(
                              size: 10,
                              color: primaryColor,
                            ),
                          );
                        } else if (state is ChatListLoaded) {
                          chatList = state.chatList;
                          if (chatList.isEmpty) {
                            return const Text('No Chats');
                          }
                          return ChatListWidget(
                              chatList: chatList, user: widget.user);
                        } else if (state is ChatError) {
                          return Text(state.message);
                        } else {
                          if (chatList.isEmpty) {
                            return const Text('No Data');
                          }
                          return ChatListWidget(
                              chatList: chatList, user: widget.user);
                        }
                      },
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
