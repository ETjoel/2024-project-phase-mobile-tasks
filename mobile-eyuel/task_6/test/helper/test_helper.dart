import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6/core/network/network_info.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_local_datasource.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:task_6/features/ecommerce/domain/repositories/product_respository.dart';

@GenerateMocks([
  ProductRepository,
  ProductLocalDataSource,
  ProductRemoteDatasource,
  NetworkInfo,
  InternetConnectionChecker,
  SharedPreferences,
  HttpClient,
  HttpClientRequest,
  HttpClientResponse,
  http.Client,
])
void main() {}
