import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entities/product.dart';
import '../repositories/product_respository.dart';

class ViewProductUsecase {
  final ProductRepository productRepository;
  const ViewProductUsecase(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(int id) {
    return productRepository.getSingleProduct(id);
  }
}
