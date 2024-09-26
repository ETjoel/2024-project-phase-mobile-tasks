import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../widgets/chat_user_widget.dart';

class DemoChatListPage extends StatelessWidget {
  const DemoChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          canvasColor: Colors.white,
          useMaterial3: true,
        ),
        home: const ChatListPage());
  }
}

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  double _dragOffset = 0.0;
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
                    Container(
                        height: 5, width: 40, color: Colors.grey.shade200),
                    const SizedBox(height: 20),
                    Expanded(
                        child: ListView.builder(
                            itemCount: 40,
                            itemBuilder: (context, index) {
                              return const ChatUser();
                            }))
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
