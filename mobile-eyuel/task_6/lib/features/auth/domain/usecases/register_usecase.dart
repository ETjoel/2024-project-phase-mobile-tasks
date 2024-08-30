import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_respository.dart';

class RegisterUserCase {
  final AuthRepository authRepository;

  RegisterUserCase(this.authRepository);

  Future<Either<Failure, Unit>> call(
      String name, String email, String password) async {
    return await authRepository.registerUser(name, email, password);
  }
}
