import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/ecommerce/data/models/product_model.dart';
import 'package:task_6/features/ecommerce/domain/usecases/update_product.dart';
import 'package:test/test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  UpdateProductUsecase updateProductUsecase =
      UpdateProductUsecase(MockProductRepository());
  MockProductRepository mockProductRepository = MockProductRepository();

  setUp(() => {
        mockProductRepository = MockProductRepository(),
        updateProductUsecase = UpdateProductUsecase(mockProductRepository)
      });

  const product = ProductModel(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 20);
  test('should return a failure or product', () async {
    when(mockProductRepository.updateProduct(product))
        .thenAnswer((_) async => const Right(unit));

    final result = await updateProductUsecase.call(product);

    expect(result, const Right(unit));
  });
}
