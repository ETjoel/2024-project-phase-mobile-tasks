import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/auth/data/model/user_model.dart';
import 'package:task_6/features/auth/data/repository/auth_repository_impl.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  const tToken = 'some_token';

  const user = UserModel('id', 'email', 'name');

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    authRepositoryImpl = AuthRepositoryImpl(
        mockAuthRemoteDataSource, mockAuthLocalDataSource, mockNetworkInfo);
  });

  void runTestOnline(Function body) {
    group('online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('loginuser', () {
    runTestOnline(() {
      test('should return unit when login is successful', () async {
        when(mockAuthRemoteDataSource.loginUser(any, any))
            .thenAnswer((_) async => tToken);

        when(mockAuthLocalDataSource.cacheToken(tToken))
            .thenAnswer((_) async {});

        final result =
            await authRepositoryImpl.loginUser('email@gmail.com', 'password');
        expect(result, const Right(unit));
      });

      test('should return error when login is failure', () async {
        when(mockAuthRemoteDataSource.loginUser(any, any))
            .thenThrow(Exception());

        when(mockAuthLocalDataSource.cacheToken(any)).thenAnswer((_) async {});

        final result =
            await authRepositoryImpl.loginUser('email@gmail.com', 'password');

        verifyZeroInteractions(mockAuthLocalDataSource);

        expect(result, Left(ServerFailure(message: Exception().toString())));
      });
    });
  });
  group('register user', () {
    runTestOnline(() {
      test('should return UserEntity when register is successful', () async {
        when(mockAuthRemoteDataSource.registerUser(any, any, any))
            .thenAnswer((_) async {});

        final result =
            await authRepositoryImpl.registerUser('name', 'email', 'passowrd');

        expect(result, const Right(unit));
      });

      test('should return error when register is failure', () async {
        when(mockAuthRemoteDataSource.registerUser(any, any, any))
            .thenThrow(Exception());

        final result =
            await authRepositoryImpl.registerUser('name', 'email', 'password');

        expect(result, Left((ServerFailure(message: Exception().toString()))));
      });
    });
  });

  group('logout user', () {
    test('should return unit when logout is successful', () async {
      when(mockAuthLocalDataSource.logout()).thenAnswer((_) async {});

      final result = await authRepositoryImpl.logoutUser();

      expect(result, const Right(unit));
    });

    test('should return failure when logut is failure', () async {
      when(mockAuthLocalDataSource.logout()).thenThrow(Exception());

      final result = await authRepositoryImpl.logoutUser();

      expect(result, Left(ServerFailure(message: Exception().toString())));
    });
  });

  group('get user', () {
    runTestOnline(() {
      test('when get user is called should return UserEntity in success',
          () async {
        when(mockAuthRemoteDataSource.getUser()).thenAnswer((_) async => user);
        when(mockAuthLocalDataSource.cacheUser(user)).thenAnswer((_) async {});
        final result = await authRepositoryImpl.getUser();

        verify(mockAuthLocalDataSource.cacheUser(user));
        expect(result, const Right(user));
      });

      test('should return failure when get user is failure', () async {
        when(mockAuthRemoteDataSource.getUser()).thenThrow(Exception());

        final result = await authRepositoryImpl.getUser();

        verifyZeroInteractions(mockAuthLocalDataSource);

        expect(result, Left(ServerFailure(message: Exception().toString())));
      });
    });
  });
}
