import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, ProductEntity>> getSingleProduct(String id);

  Future<Either<Failure, Unit>> createProduct(ProductEntity product);

  Future<Either<Failure, Unit>> updateProduct(ProductModel product);

  Future<Either<Failure, Unit>> deleteProduct(String id);
}
