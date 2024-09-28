import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> loginUser(String email, String password);
  Future<void> registerUser(String name, String email, String password);
  Future<UserModel> getUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  static const tTokenKey = 'access_token';
  static const baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3';
  AuthRemoteDataSourceImpl(this.client, this.sharedPreferences);
  @override
  Future<UserModel> getUser() async {
    final accessToken = sharedPreferences.getString(tTokenKey);
    if (accessToken != null) {
      final response = await client.get(Uri.parse('$baseUrl/users/me'),
          headers: {
            'Authorization': accessToken,
            'Content-Type': 'application/json'
          });
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('Failed to get access token');
    }
  }

  @override
  Future<String> loginUser(String email, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body)['data']['access_token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> registerUser(String name, String email, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      debugPrint(
          '${response.statusCode}, ${response.body}, $name, $email, $password');
      throw Exception('Failed to register');
    }
  }
}
