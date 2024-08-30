import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/auth/domain/usecases/logout_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late LogoutUseCase logoutUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockAuthRepository);
  });

  test('should logout user when successful', () async {
    when(mockAuthRepository.logoutUser())
        .thenAnswer((_) async => const Right(unit));

    final result = await logoutUseCase();

    expect(result, const Right(unit));
  });

  test('should return failure user when failure', () async {
    when(mockAuthRepository.logoutUser())
        .thenAnswer((_) async => const Left(ServerFailure(message: 'message')));

    final result = await logoutUseCase();

    expect(result, const Left(ServerFailure(message: 'message')));
  });
}
