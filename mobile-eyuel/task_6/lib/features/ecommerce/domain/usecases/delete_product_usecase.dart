import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../repositories/product_respository.dart';

class DeleteProductUsecase {
  final ProductRepository _productRepository;

  DeleteProductUsecase(this._productRepository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await _productRepository.deleteProduct(id);
  }
}
