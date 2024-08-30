import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/domain/entities/user.dart';
import 'package:task_6/features/chat/domain/entities/chat_entity.dart';
import 'package:task_6/features/chat/domain/usecases/initiate_chat_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockChatRepository mockChatRepository;
  late InitiateChatUseCase initiateChatUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    initiateChatUseCase = InitiateChatUseCase(mockChatRepository);
  });

  const user = UserEntity('id', 'email', 'name');
  const chat = ChatEntity('id', user, user);

  test('should return a chat', () async {
    when(mockChatRepository.initiateChat('reciverId'))
        .thenAnswer((_) async => const Right(chat));

    final result = await initiateChatUseCase.call('reciverId');

    expect(result, const Right(chat));
  });
}
