import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_6/features/auth/data/datasource/auth_remote.dart';
import 'package:task_6/features/auth/data/model/user_model.dart';

import '../../../../../fixture/fixture_reader.dart';
import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockClient mockclient;
  late MockSharedPreferences mocksharedPreferences;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  const baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v3';

  setUp(() {
    mockclient = MockClient();
    mocksharedPreferences = MockSharedPreferences();
    authRemoteDataSourceImpl =
        AuthRemoteDataSourceImpl(mockclient, mocksharedPreferences);
  });
  group('getUser', () {
    test('should return UserModel when the response code is 200', () async {
      when(mockclient.get(Uri.parse('$baseUrl/users/me'), headers: {
        'Authorization': 'some_token',
        'Content-Type': 'application/json'
      })).thenAnswer((_) async => http.Response(fixture('get_user_me'), 200));
      when(mocksharedPreferences.getString(any))
          .thenAnswer((_) => 'some_token');
      final result = await authRemoteDataSourceImpl.getUser();
      expect(result, isA<UserModel>());
    });
  });

  group('loginUser', () {
    test('should return token when the response code is 200', () async {
      when(mockclient.post(Uri.parse('$baseUrl/auth/login'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'email': 'email', 'password': 'password'})))
          .thenAnswer(
              (_) async => http.Response(fixture('login_response'), 200));
      final result =
          await authRemoteDataSourceImpl.loginUser('email', 'password');

      expect(result,
          jsonDecode(fixture('login_response'))['data']['access_token']);
    });
  });

  group('register user', () {
    test('should return UserModel when the response code is 200', () async {
      when(mockclient.post(Uri.parse('$baseUrl/auth/register'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(
                  {'name': 'name', 'email': 'email', 'password': 'password'})))
          .thenAnswer(
              (_) async => http.Response(fixture('register_response'), 200));
      await authRemoteDataSourceImpl.registerUser('name', 'email', 'password');

      verify(mockclient.post(Uri.parse('$baseUrl/auth/register'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(
                  {'name': 'name', 'email': 'email', 'password': 'password'})))
          .called(1);
    });
  });
}
