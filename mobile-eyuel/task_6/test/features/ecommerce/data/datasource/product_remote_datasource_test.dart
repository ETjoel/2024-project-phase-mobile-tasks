import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/exceptions.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:task_6/features/ecommerce/data/models/product_model.dart';

import '../../../../fixture/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockClient client;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  const id = '6672776eb905525c145fe0bb';
  final jsonProduct = fixture('json_example');
  final jsonProducts = fixture('json_products');
  const baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';
  final product = ProductModel.fromJson(json.decode(jsonProduct)['data']);
  final List<dynamic> jsonList = jsonDecode(jsonProducts)['data'];
  final List<ProductModel> products =
      jsonList.map((json) => ProductModel.fromJson(json)).toList();

  setUp(() {
    client = MockClient();
    productRemoteDataSourceImpl = ProductRemoteDataSourceImpl(client: client);
  });

  group('get single product', () {
    const id = '6672776eb905525c145fe0bb';
    final Uri url = Uri.parse('$baseUrl/$id');

    test('should perform GET request on a URL and return product on success',
        () async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(jsonProduct, 200));

      final result = await productRemoteDataSourceImpl.getSingleProduct(id);

      expect(result, product);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(client.get(url, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      final call = productRemoteDataSourceImpl.getSingleProduct;

      expect(() => call(id), throwsA(isA<ServerException>()));
    });
  });

  group('get all products', () {
    final Uri url = Uri.parse(baseUrl);

    test('should perform GET request on a URL and return product on success',
        () async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(jsonProducts, 200));
      final result = await productRemoteDataSourceImpl.getAllProducts();

      verify(client.get(url, headers: {'Content-Type': 'application/json'}))
          .called(1);
      expect(result, products);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(client.get(url, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      expect(() async => await productRemoteDataSourceImpl.getAllProducts(),
          throwsA(isA<ServerException>()));
    });
  });

  group('update product', () {
    final Uri url = Uri.parse('$baseUrl/${product.id}');

    test('should perform PUT request on a URL in success', () async {
      when(client.put(url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(product.tojson())))
          .thenAnswer((_) async => http.Response('', 200));

      await productRemoteDataSourceImpl.updateProduct(product);

      verify(client.put(url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(product.tojson())))
          .called(1);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(client.put(url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(product.tojson())))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      expect(
          () async => await productRemoteDataSourceImpl.updateProduct(product),
          throwsA(isA<ServerException>()));
    });
  });

  group('delete product', () {
    final Uri url = Uri.parse('$baseUrl/$id');

    test('should perform DELET request on a URL in success', () async {
      when(client.delete(url, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('', 200));

      await productRemoteDataSourceImpl.deleteProduct(id);

      verify(client.delete(url, headers: {'Content-Type': 'application/json'}))
          .called(1);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(client.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Something went wrong', 404));

      expect(() async => await productRemoteDataSourceImpl.deleteProduct(id),
          throwsA(isA<ServerException>()));
    });
  });
}
