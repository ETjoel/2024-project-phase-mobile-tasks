import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_entity.dart';
import '../repository/chat_respository.dart';

class ViewMyChatsUseCase {
  final ChatRepository chatRepository;

  ViewMyChatsUseCase(this.chatRepository);

  Future<Either<Failure, List<ChatEntity>>> call() async {
    return await chatRepository.viewMyChats();
  }
}
