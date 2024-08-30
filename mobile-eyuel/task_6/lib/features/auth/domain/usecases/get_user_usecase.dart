import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repository/auth_respository.dart';

class GetUserUseCase {
  final AuthRepository authRepository;

  GetUserUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.getUser();
  }
}
