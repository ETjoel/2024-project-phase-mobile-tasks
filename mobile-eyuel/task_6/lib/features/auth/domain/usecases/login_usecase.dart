import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_respository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<Failure, Unit>> call(String name, String password) async {
    return await authRepository.loginUser(name, password);
  }
}
