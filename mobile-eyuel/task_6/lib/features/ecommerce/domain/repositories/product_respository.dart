import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, ProductEntity>> getSingleProduct(int id);

  Future<Either<Failure, Unit>> createProduct(ProductEntity product);

  Future<Either<Failure, Unit>> updateProduct(ProductEntity product);

  Future<Either<Failure, Unit>> deleteProduct(int id);
}
