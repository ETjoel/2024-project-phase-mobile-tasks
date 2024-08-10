import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/domain/entities/product.dart';
import 'package:task_6/domain/usecases/view_all_products.dart';
import 'package:test/test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  ViewAllProductsUseCase viewAllProductsUseCase =
      ViewAllProductsUseCase(MockProductRepository());
  MockProductRepository mockProductRepository = MockProductRepository();

  setUp(() {
    mockProductRepository = MockProductRepository();
    viewAllProductsUseCase = ViewAllProductsUseCase(mockProductRepository);
  });

  var productDetail = [
    ProductEntity(
        id: 1,
        name: 'shoe',
        description: 'just show shoe',
        imageUrl: 'imageUrl',
        price: 20.3)
  ];

  test('should get all products from repository', () async {
    when(mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(productDetail));

    final result = await viewAllProductsUseCase();

    expect(result, Right(productDetail));
  });
}
