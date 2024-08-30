import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/data/datasource/auth_local.dart';
import 'package:task_6/features/auth/data/model/user_model.dart';

import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AuthLocalDataSourceImp authLocalDataSourceImp;

  const user = UserModel('id', 'email', 'name');

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authLocalDataSourceImp = AuthLocalDataSourceImp(mockSharedPreferences);
  });

  group('cache token', () {
    test('should return void when cachetoken is successful', () async {
      when(mockSharedPreferences.setString('access_token', 'some_token'))
          .thenAnswer((_) async => Future.value(true));

      await authLocalDataSourceImp.cacheToken('some_token');
      verify(mockSharedPreferences.setString('access_token', 'some_token'));
    });
  });

  group('cache user', () {
    test('should cache user when successful', () async {
      when(mockSharedPreferences.setString(
              'user_key', jsonEncode(user.toJson())))
          .thenAnswer((_) async => Future.value(true));

      await authLocalDataSourceImp.cacheUser(user);

      verify(mockSharedPreferences.setString(
          'user_key', jsonEncode(user.toJson())));
    });
  });

  group('get user', () {
    test('should return user when successful', () async {
      when(mockSharedPreferences.getString('user_key'))
          .thenAnswer((_) => jsonEncode(user.toJson()));

      final result = await authLocalDataSourceImp.getUser();

      expect(result, user);
    });
  });

  group('logout', () {
    test('should return void when logout is successful', () async {
      when(mockSharedPreferences.remove('access_token'))
          .thenAnswer((_) async => Future.value(true));

      when(mockSharedPreferences.remove('user_key'))
          .thenAnswer((_) async => Future.value(true));

      await authLocalDataSourceImp.logout();

      verify(mockSharedPreferences.remove('access_token'));
      verify(mockSharedPreferences.remove('user_key'));
    });
  });
}
