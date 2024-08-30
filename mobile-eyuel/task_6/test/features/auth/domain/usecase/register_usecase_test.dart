import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/auth/domain/usecases/register_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late RegisterUserCase registerUserCase;
  late MockAuthRepository mockAuthRepository;

  const String name = 'name';
  const String password = 'password';
  const String email = 'email@gmail.com';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUserCase = RegisterUserCase(mockAuthRepository);
  });

  test('should logout user when successful', () async {
    when(mockAuthRepository.registerUser(name, email, password))
        .thenAnswer((_) async => const Right(unit));

    final result = await registerUserCase.call(name, email, password);

    expect(result, const Right(unit));
  });

  test('should return failure user when failure', () async {
    when(mockAuthRepository.registerUser(name, email, password))
        .thenAnswer((_) async => const Left(ServerFailure(message: 'message')));

    final result = await registerUserCase.call(name, email, password);

    expect(result, const Left(ServerFailure(message: 'message')));
  });
}
