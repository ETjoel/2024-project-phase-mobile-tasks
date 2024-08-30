import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repository/chat_respository.dart';
import '../datasource/local_datasource/local_datasource.dart';
import '../datasource/remote_datasource/remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  final ChatLocalDataSource chatLocalDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl(
      this.chatRemoteDataSource, this.chatLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> deleteChat(String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        await chatRemoteDataSource.deleteChat(chatId);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getChatMessage(
      String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final messages = await chatRemoteDataSource.getChatMessage(userId);
        await chatLocalDataSource.cacheChatMessages(userId, messages);
        return Right(messages);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final messages = await chatLocalDataSource.getChatMessages(userId);
        return Right(messages);
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ChatEntity>> initiateChat(String recicerId) async {
    if (await networkInfo.isConnected) {
      try {
        final chat = await chatRemoteDataSource.initiateChat(recicerId);
        return Right(chat);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ChatEntity>> viewMyChatById(String chatId) async {
    if (await networkInfo.isConnected) {
      try {
        final chat = await chatRemoteDataSource.getMyChatById(chatId);
        return Right(chat);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> viewMyChats() async {
    if (await networkInfo.isConnected) {
      try {
        final chats = await chatRemoteDataSource.getMyChats();
        await chatLocalDataSource.cacheMyChats(chats);
        return Right(chats);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final chats = await chatLocalDataSource.getMyChats();
        return Right(chats);
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }
}
