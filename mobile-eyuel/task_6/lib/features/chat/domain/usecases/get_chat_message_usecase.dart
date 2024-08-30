import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/message_entity.dart';
import '../repository/chat_respository.dart';

class GetChatMessageUseCase {
  final ChatRepository chatRepository;

  GetChatMessageUseCase(this.chatRepository);

  Future<Either<Failure, List<MessageEntity>>> call(String userId) async {
    return await chatRepository.getChatMessage(userId);
  }
}
