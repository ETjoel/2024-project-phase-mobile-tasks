import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/product_model.dart';
import '../repositories/product_respository.dart';

class UpdateProductUsecase {
  final ProductRepository productRepository;
  const UpdateProductUsecase(this.productRepository);

  Future<Either<Failure, Unit>> call(ProductModel product) {
    return productRepository.updateProduct(product);
  }
}
