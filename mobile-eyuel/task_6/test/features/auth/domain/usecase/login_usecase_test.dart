import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/auth/domain/usecases/login_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const String name = 'name';
  const String password = 'password';

  test('should login user when successful', () async {
    when(mockAuthRepository.loginUser(name, password))
        .thenAnswer((_) async => const Right(unit));

    final result = await loginUseCase.call(name, password);

    expect(result, const Right(unit));
  });

  test('should return failure login when failure', () async {
    when(mockAuthRepository.loginUser(name, password))
        .thenAnswer((_) async => const Left(ServerFailure(message: 'message')));

    final result = await loginUseCase.call(name, password);

    expect(result, const Left(ServerFailure(message: 'message')));
  });
}
