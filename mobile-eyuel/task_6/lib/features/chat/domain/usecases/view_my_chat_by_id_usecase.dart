import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_entity.dart';
import '../repository/chat_respository.dart';

class ViewMyChatByIdUseCase {
  final ChatRepository chatRepository;

  ViewMyChatByIdUseCase(this.chatRepository);

  Future<Either<Failure, ChatEntity>> call(String id) async {
    return await chatRepository.viewMyChatById(id);
  }
}
