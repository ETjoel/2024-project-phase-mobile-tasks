import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_entity.dart';
import '../repository/chat_respository.dart';

class InitiateChatUseCase {
  final ChatRepository chatRepository;

  InitiateChatUseCase(this.chatRepository);

  Future<Either<Failure, ChatEntity>> call(String reciverId) async {
    return await chatRepository.initiateChat(reciverId);
  }
}
