import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/exceptions.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/ecommerce/data/models/product_model.dart';
import 'package:task_6/features/ecommerce/data/repositories/product_respository_impl.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  const id = '1';

  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl(
      productLocalDataSource: MockProductLocalDataSource(),
      productRemoteDatasource: MockProductRemoteDatasource(),
      networkInfo: MockNetworkInfo());
  MockProductLocalDataSource mockProductLocalDataSource =
      MockProductLocalDataSource();
  MockProductRemoteDatasource mockProductRemoteDatasource =
      MockProductRemoteDatasource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();

  const productModel = ProductModel(
      id: '1',
      name: 'shoe',
      description: 'just show shoe',
      imageUrl: 'imageUrl',
      price: 20.3);

  final productModels = [productModel];

  void runTestOnline(Function body) {
    group('online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  setUp(() {
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockProductRemoteDatasource = MockProductRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    productRepositoryImpl = ProductRepositoryImpl(
        productLocalDataSource: mockProductLocalDataSource,
        productRemoteDatasource: mockProductRemoteDatasource,
        networkInfo: mockNetworkInfo);
  });

  group('view product usecase', () {
    test('chieck if there is internet connection', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDatasource.getSingleProduct(any))
          .thenAnswer((_) async => productModel);

      productRepositoryImpl.getSingleProduct(id);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'should return ProductModel when the call to getSingleProduct in remote data source  is successful',
          () async {
        when(mockProductRemoteDatasource.getSingleProduct(any))
            .thenAnswer((_) async => productModel);

        final result = await productRepositoryImpl.getSingleProduct(id);

        verify(mockProductRemoteDatasource.getSingleProduct(id));
        expect(result, const Right(productModel));
      });

      test(
          'should return failure when the call to getSingleProduct in remote data source  is failded',
          () async {
        when(mockProductRemoteDatasource.getSingleProduct(id))
            .thenThrow(Exception());

        final result = await productRepositoryImpl.getSingleProduct(id);
        verifyZeroInteractions(mockProductLocalDataSource);
        expect(result, Left(ServerFailure(message: Exception().toString())));
      });
    });
    runTestOffline(() {
      test('should throw failure when the call to getSingleProduct failed',
          () async {
        when(mockProductRemoteDatasource.getSingleProduct(id))
            .thenThrow(const ServerFailure(message: 'No internet connection'));

        final result = await productRepositoryImpl.getSingleProduct(id);

        expect(result,
            const Left(ServerFailure(message: 'No internet connection')));
      });
    });
  });

  group('view all product usecase', () {
    test('chieck if there is internet connection', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDatasource.getAllProducts())
          .thenAnswer((_) async => productModels);

      productRepositoryImpl.getAllProducts();

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'should return list of ProductModel when the call to getAllproduct in remote data source  is successful',
          () async {
        when(mockProductRemoteDatasource.getAllProducts())
            .thenAnswer((_) async => productModels);

        final result = await productRepositoryImpl.getAllProducts();

        verify(mockProductRemoteDatasource.getAllProducts());
        verify(mockProductLocalDataSource.cacheAllProducts(productModels));
        expect(result, Right(productModels));
      });

      test(
          'should return failure when the call to getAllproduct in remote data source  is failed',
          () async {
        when(mockProductRemoteDatasource.getAllProducts())
            .thenThrow(Exception()); // Remove the 'const' keyword

        final result = await productRepositoryImpl.getAllProducts();
        verifyZeroInteractions(mockProductLocalDataSource);
        expect(
            result,
            Left(ServerFailure(
                message:
                    Exception().toString()))); // Remove the 'const' keyword
      });
    });
    runTestOffline(() {
      test(
          'should fetch from local cache when the call to getAllProduct is called and there is no internet connection',
          () async {
        when(mockProductLocalDataSource.getAllProducts())
            .thenAnswer((_) async => productModels);

        final result = await productRepositoryImpl.getAllProducts();
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, Right(productModels));
      });

      test(
          'should return failure from local cache when the call to getAllProduct is called and there is no internet connection and failed',
          () async {
        when(mockProductLocalDataSource.getAllProducts())
            .thenThrow(CacheException());

        final result = await productRepositoryImpl.getAllProducts();
        expect(result, const Left(CacheFailure(message: 'Cache Error')));
      });
    });
  });

  group('create product', () {
    runTestOnline(() {
      test('should return unit when the call to createProduct is successful',
          () async {
        when(mockProductRemoteDatasource.createProduct(productModel))
            .thenAnswer((_) async {});

        final result = await productRepositoryImpl.createProduct(productModel);
        verify(mockProductRemoteDatasource.createProduct(productModel));
        expect(result, const Right(unit));
      });

      test('should return failure when the call to createProduct is failed',
          () async {
        when(mockProductRemoteDatasource.createProduct(productModel))
            .thenThrow(Exception());

        final result = await productRepositoryImpl.createProduct(productModel);
        expect(result, Left(ServerFailure(message: Exception().toString())));
      });
    });

    runTestOffline(() {
      test(
          'should return failure when the call to createProduct and when offline',
          () async {
        when(mockProductRemoteDatasource.createProduct(productModel))
            .thenThrow(ServerException());

        final result = await productRepositoryImpl.createProduct(productModel);
        expect(result,
            const Left(ServerFailure(message: 'No internet connection')));
      });
    });
  });

  group('delete product', () {
    runTestOnline(() {
      test('should return unit when the call to deleteProduct is successful',
          () async {
        when(mockProductRemoteDatasource.deleteProduct(id))
            .thenAnswer((_) async {});

        final result = await productRepositoryImpl.deleteProduct(id);
        verify(mockProductRemoteDatasource.deleteProduct(id));
        expect(result, const Right(unit));
      });

      test('should return failure when the call to deleteProduct is failed',
          () async {
        when(mockProductRemoteDatasource.deleteProduct(id))
            .thenThrow(Exception());

        final result = await productRepositoryImpl.deleteProduct(id);
        expect(result, Left(ServerFailure(message: Exception().toString())));
      });
    });

    runTestOffline(() {
      test('should return failure when the call to deleteProduct', () async {
        when(mockProductRemoteDatasource.deleteProduct(id))
            .thenThrow(ServerException());

        final result = await productRepositoryImpl.deleteProduct(id);
        expect(result,
            const Left(ServerFailure(message: 'No internet connection')));
      });
    });
  });

  group('update product', () {
    runTestOnline(() {
      test('should return unit when the call to updateProduct is successful',
          () async {
        when(mockProductRemoteDatasource.updateProduct(productModel))
            // ignore: avoid_returning_null_for_void
            .thenAnswer((_) async => null);

        final result = await productRepositoryImpl.updateProduct(productModel);
        verify(mockProductRemoteDatasource.updateProduct(productModel));
        expect(result, const Right(unit));
      });

      test('should return failure when the call to updateProduct is failed',
          () async {
        when(mockProductRemoteDatasource.updateProduct(productModel))
            .thenThrow(Exception());

        final result = await productRepositoryImpl.updateProduct(productModel);
        expect(result, Left(ServerFailure(message: Exception().toString())));
      });
    });

    runTestOffline(() {
      test('should return failure when the call to updateProduct', () async {
        when(mockProductRemoteDatasource.updateProduct(productModel))
            .thenThrow(ServerException());

        final result = await productRepositoryImpl.updateProduct(productModel);
        expect(result,
            const Left(ServerFailure(message: 'No internet connection')));
      });
    });
  });
}
