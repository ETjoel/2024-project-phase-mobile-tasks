import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getSingleProduct(String id);
  Future<void> createProduct(ProductEntity product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDatasource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v3/products';

  static const String tTokenKey = 'access_token';

  ProductRemoteDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  @override
  Future<void> createProduct(ProductEntity product) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token == null) {
      throw const AuthFailure();
    }
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.headers
        .addAll({'Authorization': token, 'Content-Type': 'application/json'});
    request.fields.addAll({
      'name': product.name,
      'description': product.description,
      'price': product.price.toString()
    });
    request.files.add(await http.MultipartFile.fromPath(
        'image', product.imageUrl,
        contentType: MediaType('image', 'jpg')));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token == null) {
      throw const AuthFailure();
    }
    final response = await client.delete(Uri.parse('$baseUrl/$id'),
        headers: {'Authorization': token, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token == null) {
      throw const AuthFailure();
    }
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['data'];
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      return products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getSingleProduct(String id) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token == null) {
      throw const AuthFailure();
    }
    final response = await client.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final token = sharedPreferences.getString(tTokenKey);
    if (token == null) {
      throw const AuthFailure();
    }
    final response = await client.put(Uri.parse('$baseUrl/${product.id}'),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode(product.tojson()));

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }
}
