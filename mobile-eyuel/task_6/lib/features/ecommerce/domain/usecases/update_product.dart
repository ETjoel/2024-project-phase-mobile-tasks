import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product.dart';
import '../repositories/product_respository.dart';

class UpdateProductUsecase {
  final ProductRepository productRepository;
  const UpdateProductUsecase(this.productRepository);

  Future<Either<Failure, Unit>> call(ProductEntity product) {
    return productRepository.updateProduct(product);
  }
}
