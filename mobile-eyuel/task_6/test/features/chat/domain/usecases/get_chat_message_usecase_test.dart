import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/domain/entities/user.dart';
import 'package:task_6/features/chat/domain/entities/chat_entity.dart';
import 'package:task_6/features/chat/domain/entities/message_entity.dart';
import 'package:task_6/features/chat/domain/usecases/get_chat_message_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockChatRepository mockChatRepository;
  late GetChatMessageUseCase getChatMessageUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    getChatMessageUseCase = GetChatMessageUseCase(mockChatRepository);
  });

  const user = UserEntity('id', 'email', 'name');
  const chat = ChatEntity('id', user, user);
  const message = MessageEntity('id', chat, 'content', 'type');

  test('should return a chat', () async {
    when(mockChatRepository.getChatMessage('id'))
        .thenAnswer((_) async => const Right([message]));

    final result = await getChatMessageUseCase.call('id');

    expect(result, const Right([message]));
  });
}
