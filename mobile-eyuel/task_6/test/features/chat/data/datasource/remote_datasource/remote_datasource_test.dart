import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/chat/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:task_6/features/chat/data/models/chat_model.dart';
import 'package:task_6/features/chat/data/models/message_model.dart';

import '../../../../../fixture/fixture_reader.dart';
import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockClient mockClient;
  late MockSharedPreferences mockSharedPreferences;
  late ChatRemoteDataSourceImpl chatRemoteDataSourceImpl;
  const baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3/chats';

  List<MessageModel> messages = [];
  for (var json in jsonDecode(fixture('get_chat_message'))['data']) {
    messages.add(MessageModel.fromJson(json));
  }

  final chat =
      ChatModel.fromJson(jsonDecode(fixture('get_my_chat_by_id'))['data']);

  List<ChatModel> chats = [];
  jsonDecode(fixture('get_my_chats'))['data'].forEach((json) {
    chats.add(ChatModel.fromJson(json));
  });

  setUp(() {
    mockClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    chatRemoteDataSourceImpl =
        ChatRemoteDataSourceImpl(mockClient, mockSharedPreferences);
  });

  test('should return null on delet chat success', () async {
    when(mockClient.delete(Uri.parse('$baseUrl/userId'), headers: {
      'Authorization': 'some_token',
      'Content-Type': 'application/json'
    })).thenAnswer((_) async => http.Response('', 200));
    when(mockSharedPreferences.getString('access_token'))
        .thenAnswer((_) => 'some_token');
    final result = await chatRemoteDataSourceImpl.deleteChat('userId');
    verify(mockClient.delete(Uri.parse('$baseUrl/userId'), headers: {
      'Authorization': 'some_token',
      'Content-Type': 'application/json'
    }));
  });

  test('should throw CacheFailure on delete chat failure', () async {
    when(mockSharedPreferences.getString('access_token'))
        .thenAnswer((_) => null);
    expect(() async => await chatRemoteDataSourceImpl.deleteChat('userId'),
        throwsA(isA<AuthFailure>()));
  });

  test('should return list of MessageModel on getChatMessage success',
      () async {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('get_chat_message'), 200));
    when(mockSharedPreferences.getString(any)).thenAnswer((_) => 'some_token');

    final result = await chatRemoteDataSourceImpl.getChatMessage('userId');
    expect(result, messages);
  });

  test('should return chat in getMyChatById success', () async {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('get_my_chat_by_id'), 200));

    when(mockSharedPreferences.getString(any)).thenAnswer((_) => 'some_token');

    final result = await chatRemoteDataSourceImpl.getMyChatById(chat.id);
    expect(result, chat);
  });

  test('should return list of chats in getMyChat success', () async {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('get_my_chats'), 200));

    when(mockSharedPreferences.getString(any)).thenAnswer((_) => 'some_token');

    final result = await chatRemoteDataSourceImpl.getMyChats();
    expect(result, chats);
  });

  test('should return chat in initiateChat success', () async {
    when(mockClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response(fixture('get_my_chat_by_id'), 200));

    when(mockSharedPreferences.getString(any)).thenAnswer((_) => 'some_token');

    final result = await chatRemoteDataSourceImpl.initiateChat(chat.user1.id);
    expect(result, chat);
  });
}
