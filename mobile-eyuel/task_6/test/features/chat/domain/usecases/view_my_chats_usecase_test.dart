import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/domain/entities/user.dart';
import 'package:task_6/features/chat/domain/entities/chat_entity.dart';
import 'package:task_6/features/chat/domain/usecases/view_my_chats_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late ViewMyChatsUseCase viewMyChatsUsecase;
  late MockChatRepository mockChatRepository;
  const user = UserEntity('id', 'email', 'name');
  const chats = ChatEntity('id', user, user);

  setUp(() {
    mockChatRepository = MockChatRepository();
    viewMyChatsUsecase = ViewMyChatsUseCase(mockChatRepository);
  });

  test('should return a list of chats', () async {
    when(mockChatRepository.viewMyChats())
        .thenAnswer((_) async => const Right([chats]));

    final result = await viewMyChatsUsecase.call();
    expect(result, const Right([chats]));
  });
}
