import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_respository.dart';

class CreateProductUsecase {
  final ProductRepository repository;

  CreateProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(ProductEntity product) async {
    return await repository.createProduct(product);
  }
}
