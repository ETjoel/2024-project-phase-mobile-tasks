import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/chat_entity.dart';
import '../../models/chat_model.dart';
import '../../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getMyChats();
  Future<ChatEntity> getMyChatById(String chatId);
  Future<ChatEntity> initiateChat(String receiverId);
  Future<List<MessageModel>> getChatMessage(String userId);
  Future<void> deleteChat(String chatId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  static const baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats';
  static const tTokenKey = 'access_token';

  ChatRemoteDataSourceImpl(this.client, this.sharedPreferences);
  @override
  Future<void> deleteChat(String chatId) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token != null) {
      final result = await client.delete(Uri.parse('$baseUrl/$chatId'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      if (result.statusCode == 200) {
        return;
      } else {
        throw const ServerFailure(message: 'Failed to delete chat');
      }
    } else {
      throw const AuthFailure();
    }
  }

  @override
  Future<List<MessageModel>> getChatMessage(String userId) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token != null) {
      final response = await client.get(Uri.parse('$baseUrl/$userId/messages'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      if (response.statusCode == 200) {
        final List<MessageModel> messages = [];
        for (var json in jsonDecode(response.body)['data']) {
          messages.add(MessageModel.fromJson(json));
        }
        return messages;
      } else {
        throw const ServerFailure(message: 'Failed to get chat messages');
      }
    } else {
      throw const AuthFailure();
    }
  }

  @override
  Future<ChatEntity> getMyChatById(String chatId) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token != null) {
      final response = await client.get(Uri.parse('$baseUrl/$chatId'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });

      if (response.statusCode == 200) {
        return ChatModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw const ServerFailure(message: 'Failed to get chat');
      }
    } else {
      throw const AuthFailure();
    }
  }

  @override
  Future<List<ChatModel>> getMyChats() {
    final token = sharedPreferences.getString(tTokenKey);
    if (token != null) {
      return client.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      }).then((response) {
        if (response.statusCode == 200) {
          final List<ChatModel> chats = [];
          for (var json in jsonDecode(response.body)['data']) {
            chats.add(ChatModel.fromJson(json));
          }
          return chats;
        } else {
          throw const ServerFailure(message: 'Failed to get chats');
        }
      });
    } else {
      throw const AuthFailure();
    }
  }

  @override
  Future<ChatEntity> initiateChat(String receiverId) {
    final token = sharedPreferences.getString(tTokenKey);
    if (token != null) {
      return client
          .post(Uri.parse(baseUrl),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json'
              },
              body: jsonEncode({'userId': receiverId}))
          .then((response) {
        if (response.statusCode == 200) {
          return ChatModel.fromJson(jsonDecode(response.body)['data']);
        } else {
          throw const ServerFailure(message: 'Failed to initiate chat');
        }
      });
    } else {
      throw const AuthFailure();
    }
  }
}
