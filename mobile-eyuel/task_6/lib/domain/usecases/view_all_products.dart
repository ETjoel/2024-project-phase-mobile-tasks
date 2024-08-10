import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_respository.dart';

class ViewAllProductsUseCase {
  final ProductRepository productRepository;

  const ViewAllProductsUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> call() {
    return productRepository.getAllProducts();
  }
}
