import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_respository.dart';
import '../datasource/product_local_datasource.dart';
import '../datasource/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;
  final ProductRemoteDatasource productRemoteDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.productLocalDataSource,
      required this.productRemoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, ProductEntity>> getSingleProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await productRemoteDatasource.getSingleProduct(id);
        return Right(product);
      } on ServerException {
        return const Left(ServerFailure(message: 'Server Error'));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await productRemoteDatasource.getAllProducts();
        productLocalDataSource.cacheAllProducts(products);
        return Right(products);
      } on ServerException {
        return const Left(ServerFailure(message: 'Server Error'));
      }
    } else {
      try {
        final products = await productLocalDataSource.getAllProducts();
        return Right(products);
      } on CacheException {
        return const Left(CacheFailure(message: 'Cache Error'));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createProduct(ProductEntity product) async {
    return _createOrUpdateOrDelete(() {
      productRemoteDatasource.createProduct(product);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    return _createOrUpdateOrDelete(() {
      productRemoteDatasource.deleteProduct(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(ProductModel product) async {
    return _createOrUpdateOrDelete(() {
      productRemoteDatasource.updateProduct(product);
    });
  }

  Future<Either<Failure, Unit>> _createOrUpdateOrDelete(Function body) async {
    if (await networkInfo.isConnected) {
      try {
        await body();
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure(message: 'Server Error'));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
