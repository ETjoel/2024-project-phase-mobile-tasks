import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/domain/entities/product.dart';
import 'package:task_6/domain/usecases/view_single_product.dart';
import 'package:test/test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  ViewProductUsecase viewProductUsecase =
      ViewProductUsecase(MockProductRepository());
  MockProductRepository mockProductRepository = MockProductRepository();

  var productDetail = ProductEntity(
      id: 1,
      name: 'shoe',
      description: 'just show shoe',
      imageUrl: 'imageUrl',
      price: 20.3);
  setUp(() => {
        mockProductRepository = MockProductRepository(),
        viewProductUsecase = ViewProductUsecase(mockProductRepository)
      });

  test('should get single product from repository', () async {
    when(mockProductRepository.getSingleProduct(1))
        .thenAnswer((_) async => Right(productDetail));

    final result = await viewProductUsecase.execute(1);

    expect(result, Right(productDetail));
  });
}
