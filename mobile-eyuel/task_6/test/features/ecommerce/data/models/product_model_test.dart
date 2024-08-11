import 'package:flutter_test/flutter_test.dart';
import 'package:task_6/features/ecommerce/data/models/product_model.dart';
import 'package:task_6/features/ecommerce/domain/entities/product.dart';

void main() {
  final product = ProductModel(
      id: 1,
      name: 'name',
      price: 30,
      description: 'description',
      imageUrl: 'imageUrl');

  test('should be a subclass of Product entity', () {
    expect(product, isA<ProductEntity>());
  });

  group('to json', () {
    test('should return a proper json data', () {
      final Map<String, dynamic> result = product.tojson();

      expect(result, {
        'id': 1,
        'name': 'name',
        'price': 30,
        'description': 'description',
        'imageUrl': 'imageUrl'
      });
    });
  });
}
