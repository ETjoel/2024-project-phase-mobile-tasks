import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/failure.dart';
import '../../models/chat_model.dart';
import '../../models/message_model.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatModel>> getMyChats();
  Future<void> cacheMyChats(List<ChatModel> chats);
  Future<void> cacheChatMessages(String userId, List<MessageModel> messages);
  Future<List<MessageModel>> getChatMessages(String userId);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final SharedPreferences sharedPreferences;

  ChatLocalDataSourceImpl(this.sharedPreferences);

  static const myChatKey = 'my_chats';

  @override
  Future<void> cacheChatMessages(
      String userId, List<MessageModel> messages) async {
    final messagesString = jsonEncode(messages.map((e) => e.toJson()).toList());
    if (await sharedPreferences.setString(userId, messagesString)) {
      return Future.value();
    } else {
      throw const CacheFailure(message: 'Failed to cache data');
    }
  }

  @override
  Future<void> cacheMyChats(List<ChatModel> chats) async {
    final chatsString = jsonEncode(chats.map((e) => e.toJson()).toList());
    if (await sharedPreferences.setString(myChatKey, chatsString)) {
      return;
    } else {
      throw const CacheFailure(message: 'Failed to cache data');
    }
  }

  @override
  Future<List<MessageModel>> getChatMessages(String userId) async {
    final result = sharedPreferences.getString(userId);
    if (result != null) {
      List<MessageModel> messages = [];
      for (var json in jsonDecode(result)) {
        messages.add(MessageModel.fromJson(json));
      }
      return Future.value(messages);
    } else {
      throw const CacheFailure(message: 'No data found');
    }
  }

  @override
  Future<List<ChatModel>> getMyChats() {
    final result = sharedPreferences.getString(myChatKey);
    if (result != null) {
      List<ChatModel> chats = [];
      for (var json in jsonDecode(result)) {
        chats.add(ChatModel.fromJson(json));
      }
      return Future.value(chats);
    } else {
      throw const CacheFailure(message: 'No data found');
    }
  }
}
