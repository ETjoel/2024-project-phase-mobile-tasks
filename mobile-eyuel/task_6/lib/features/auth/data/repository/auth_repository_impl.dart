import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_respository.dart';
import '../datasource/auth_local.dart';
import '../datasource/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.authLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> loginUser(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await authRemoteDataSource.loginUser(email, password);
        await authLocalDataSource.cacheToken(token);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logoutUser() async {
    try {
      await authLocalDataSource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> registerUser(
      String name, String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.registerUser(name, email, password);
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await authRemoteDataSource.getUser();
        await authLocalDataSource.cacheUser(user);

        return Right(user);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final user = await authLocalDataSource.getUser();
        return Right(user);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    }
  }
}
