import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/auth/data/model/user_model.dart';
import 'package:task_6/features/chat/data/models/chat_model.dart';
import 'package:task_6/features/chat/data/models/message_model.dart';
import 'package:task_6/features/chat/data/repository/chat_repository_impl.dart';
import 'package:task_6/features/chat/domain/entities/chat_entity.dart';
import 'package:task_6/features/chat/domain/entities/message_entity.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockChatRemoteDataSource mockChatRemoteDataSource;
  late MockChatLocalDataSource mockChatLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ChatRepositoryImpl chatRepositoryImpl;
  late MockSharedPreferences mockSharedPreferences;

  const user = UserModel('id', 'email', 'name');
  const chat = ChatModel('id', user, user);
  const message = MessageModel('id', chat, 'content', 'type');

  setUp(() {
    mockChatRemoteDataSource = MockChatRemoteDataSource();
    mockChatLocalDataSource = MockChatLocalDataSource();
    mockSharedPreferences = MockSharedPreferences();
    mockNetworkInfo = MockNetworkInfo();
    chatRepositoryImpl = ChatRepositoryImpl(mockChatRemoteDataSource,
        mockChatLocalDataSource, mockNetworkInfo, mockSharedPreferences);
  });
  void runTestOnline(Function body) {
    group('online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('shared preference is not null', () {
    setUp(() {
      when(mockSharedPreferences.getString(any)).thenAnswer((_) => 'som_token');
    });

    group('view my chats', () {
      runTestOnline(() {
        test('view my chats successful on online', () async {
          when(mockChatRemoteDataSource.getMyChats())
              .thenAnswer((_) async => [chat]);
          final result = await chatRepositoryImpl.viewMyChats();
          verify(mockChatLocalDataSource.cacheMyChats([chat]));
          expect(result.runtimeType,
              const Right<Failure, List<ChatEntity>>([chat]).runtimeType);
        });
      });

      runTestOffline(() {
        test('view my chats successful on offline', () async {
          when(mockChatLocalDataSource.getMyChats())
              .thenAnswer((_) async => [chat]);
          final result = await chatRepositoryImpl.viewMyChats();
          expect(result.runtimeType,
              const Right<Failure, List<ChatEntity>>([chat]).runtimeType);
        });

        test('view my chats should return failure on offline', () async {
          when(mockChatLocalDataSource.getMyChats()).thenThrow(Exception());
          final result = await chatRepositoryImpl.viewMyChats();
          expect(result, Left(CacheFailure(message: Exception().toString())));
        });
      });
    });

    group('view my chat by id', () {
      runTestOnline(() {
        test('should return chat in success and online', () async {
          when(mockChatRemoteDataSource.getMyChatById('chatId'))
              .thenAnswer((_) async => chat);
          final result = await chatRepositoryImpl.viewMyChatById('chatId');
          expect(result, const Right(chat));
        });
      });
    });

    group('initiate chat', () {
      runTestOnline(() {
        test('should sucessfuly initiate chat when successful', () async {
          when(mockChatRemoteDataSource.initiateChat('recieverId'))
              .thenAnswer((_) async => chat);
          final result = await chatRepositoryImpl.initiateChat('recieverId');
          expect(result, const Right(chat));
        });
      });
    });

    group('get chat message', () {
      runTestOnline(() {
        test('should return message when successful', () async {
          when(mockChatRemoteDataSource.getChatMessage('userId'))
              .thenAnswer((_) async => [message]);
          final result = await chatRepositoryImpl.getChatMessage('userId');
          expect(result.runtimeType,
              const Right<Failure, List<MessageEntity>>([message]).runtimeType);
        });
      });
    });
    group('delete chat', () {
      runTestOnline(() {
        test('should return unit when successful', () async {
          when(mockChatRemoteDataSource.deleteChat('chatId'))
              .thenAnswer((_) async {});
          final result = await chatRepositoryImpl.deleteChat('chatId');
          expect(result, const Right(unit));
        });
      });
    });
  });
}
