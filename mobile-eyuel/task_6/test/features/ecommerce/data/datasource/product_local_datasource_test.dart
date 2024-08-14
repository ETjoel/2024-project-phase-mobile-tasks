import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_local_datasource.dart';
import 'package:task_6/features/ecommerce/data/models/product_model.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  ProductLocalDataSourceImpl productLocalDataSourceImpl =
      ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

  final products = [
    const ProductModel(
        id: '1',
        name: 'name',
        price: 30.0,
        description: 'description',
        imageUrl: 'imageUrl')
  ];

  final jsonString =
      jsonEncode(products.map((product) => product.tojson()).toList());

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    productLocalDataSourceImpl =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('cache all products', () {
    test('should cache all products', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      await productLocalDataSourceImpl.cacheAllProducts(products);

      verify(mockSharedPreferences.setString(
        ProductLocalDataSourceImpl.cachedProduct,
        jsonString,
      )).called(1);
    });

    test('should throw CacheFailure when caching fails', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => false);

      expect(
          () async =>
              await productLocalDataSourceImpl.cacheAllProducts(products),
          throwsA(isA<CacheFailure>()));
    });
  });

  group('get all products', () {
    test('should return all products', () async {
      when(mockSharedPreferences.getString(any))
          .thenAnswer((realInvocation) => jsonString);

      final result = await productLocalDataSourceImpl.getAllProducts();

      expect(result, products);
    });

    test('should throw CacheFailure when there is no cached product', () async {
      when(mockSharedPreferences.getString(any)).thenAnswer((_) => null);

      expect(() async {
        await productLocalDataSourceImpl.getAllProducts();
      }, throwsA(const CacheFailure(message: 'Cache Error')));
    });
  });
}
