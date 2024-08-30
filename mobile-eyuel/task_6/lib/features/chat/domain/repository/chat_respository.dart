import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatEntity>>> viewMyChats();
  Future<Either<Failure, ChatEntity>> viewMyChatById(String id);
  Future<Either<Failure, ChatEntity>> initiateChat(String recicerId);

  Future<Either<Failure, List<MessageEntity>>> getChatMessage(String userId);
  Future<Either<Failure, Unit>> deleteChat(String chatId);
}
