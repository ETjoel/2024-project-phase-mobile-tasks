import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/chat/domain/usecases/delete_chat.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockChatRepository mockChatRepository;
  late DeleteChatUseCase deleteChatUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    deleteChatUseCase = DeleteChatUseCase(mockChatRepository);
  });

  test('should return a unit', () async {
    when(mockChatRepository.deleteChat('chatId'))
        .thenAnswer((_) async => const Right(unit));

    final result = await deleteChatUseCase.call('chatId');

    expect(result, const Right(unit));
  });
}
