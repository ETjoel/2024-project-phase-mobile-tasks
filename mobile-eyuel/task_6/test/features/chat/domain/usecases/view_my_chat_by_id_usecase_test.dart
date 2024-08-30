import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/domain/entities/user.dart';
import 'package:task_6/features/chat/domain/entities/chat_entity.dart';
import 'package:task_6/features/chat/domain/usecases/view_my_chat_by_id_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockChatRepository mockChatRepository;
  late ViewMyChatByIdUseCase viewMyChatByIdUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    viewMyChatByIdUseCase = ViewMyChatByIdUseCase(mockChatRepository);
  });

  const user = UserEntity('id', 'email', 'name');
  const chat = ChatEntity('id', user, user);

  test('should return a chat', () async {
    when(mockChatRepository.viewMyChatById('id'))
        .thenAnswer((_) async => const Right(chat));

    final result = await viewMyChatByIdUseCase.call('id');

    expect(result, const Right(chat));
  });
}
