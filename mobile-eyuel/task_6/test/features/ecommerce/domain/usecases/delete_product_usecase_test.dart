import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'package:test/test.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  DeleteProductUsecase deleteProductUsecase =
      DeleteProductUsecase(MockProductRepository());
  MockProductRepository mockProductRepository = MockProductRepository();

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUsecase = DeleteProductUsecase(mockProductRepository);
  });

  test('should return null or failure', () async {
    when(mockProductRepository.deleteProduct(1))
        .thenAnswer((_) async => const Right(unit));

    final result = await deleteProductUsecase.call(1);

    expect(result, const Right(unit));
  });
}
