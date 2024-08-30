import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/data/model/user_model.dart';
import 'package:task_6/features/chat/data/datasource/local_datasource/local_datasource.dart';
import 'package:task_6/features/chat/data/models/chat_model.dart';
import 'package:task_6/features/chat/data/models/message_model.dart';

import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ChatLocalDataSourceImpl chatLocalDataSourceImpl;

  const user = UserModel('id', 'email', 'name');
  const chat = ChatModel('id', user, user);
  const message = MessageModel('id', chat, 'content', 'type');
  const messages = [message];

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    chatLocalDataSourceImpl = ChatLocalDataSourceImpl(mockSharedPreferences);
  });

  test('should get chat Messages', () async {
    when(mockSharedPreferences.getString(any)).thenAnswer(
        (_) => jsonEncode(messages.map((e) => e.toJson()).toList()));
    final result = await chatLocalDataSourceImpl.getChatMessages('userId');
    expect(result, List<MessageModel>.from([message]));
  });

  test('should return null when cacheChatMessages successful', () async {
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);

    await chatLocalDataSourceImpl.cacheChatMessages('userId', messages);
    verify(mockSharedPreferences.setString(
        'userId', jsonEncode(messages.map((e) => e.toJson()).toList())));
  });
}
