import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import '../model/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<void> logout();
  Future<UserEntity> getUser();
  Future<void> cacheUser(UserModel user);
}

class AuthLocalDataSourceImp extends AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const tTokenKey = 'access_token';
  static const userKey = 'user_key';

  AuthLocalDataSourceImp(this.sharedPreferences);
  @override
  Future<void> cacheToken(String token) async {
    if (await sharedPreferences.setString(tTokenKey, token)) {
      return;
    } else {
      throw const CacheFailure(message: 'cache error');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    if (await sharedPreferences.setString(userKey, jsonEncode(user.toJson()))) {
      return;
    } else {
      throw const CacheFailure(message: 'cache error');
    }
  }

  @override
  Future<UserEntity> getUser() {
    final userString = sharedPreferences.getString(userKey);
    if (userString != null) {
      final user = UserModel.fromJson(jsonDecode(userString));
      return Future.value(user);
    } else {
      throw const CacheFailure(message: 'cache error');
    }
  }

  @override
  Future<void> logout() async {
    final token = await sharedPreferences.remove(tTokenKey);
    final user = await sharedPreferences.remove(userKey);

    if (token && user) {
      return;
    } else {
      throw const CacheFailure(message: 'cache error');
    }
  }
}
