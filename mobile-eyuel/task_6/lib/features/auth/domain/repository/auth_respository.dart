import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> registerUser(
      String name, String email, String passowrd);
  Future<Either<Failure, Unit>> loginUser(String name, String password);
  Future<Either<Failure, Unit>> logoutUser();
  Future<Either<Failure, UserEntity>> getUser();
}
