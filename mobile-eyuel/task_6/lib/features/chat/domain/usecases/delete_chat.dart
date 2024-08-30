import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/chat_respository.dart';

class DeleteChatUseCase {
  final ChatRepository chatRepository;

  DeleteChatUseCase(this.chatRepository);
  Future<Either<Failure, Unit>> call(String chatId) async {
    return await chatRepository.deleteChat(chatId);
  }
}
