import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
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

  static const String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createProduct(ProductEntity product) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.fields.addAll({
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'price': product.price.toString(),
      'imageUrl': product.imageUrl,
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', product.imageUrl));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
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
    final response = await client.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final response = await client.put(Uri.parse('$baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.tojson()));

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }
}
