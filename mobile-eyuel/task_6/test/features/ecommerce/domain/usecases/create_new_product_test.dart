import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/ecommerce/domain/entities/product.dart';
import 'package:task_6/features/ecommerce/domain/usecases/create_new_product.dart';
import 'package:test/test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  CreateProductUsecase createProductUsecase =
      CreateProductUsecase(MockProductRepository());
  MockProductRepository mockProductRepository = MockProductRepository();

  final product = ProductEntity(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 40.5);

  setUp(() => {
        mockProductRepository = MockProductRepository(),
        createProductUsecase = CreateProductUsecase(mockProductRepository)
      });
  test('should create new product', () async {
    when(mockProductRepository.createProduct(product))
        .thenAnswer((_) async => const Right(unit));

    final result = await createProductUsecase.call(product);

    expect(result, const Right(unit));
  });
}
