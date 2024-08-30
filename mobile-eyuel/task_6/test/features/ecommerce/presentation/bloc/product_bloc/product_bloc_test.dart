import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_6/core/errors/failure.dart';
import 'package:task_6/features/ecommerce/data/models/product_model.dart';
import 'package:task_6/features/ecommerce/domain/entities/product.dart';
import 'package:task_6/features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';

import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockViewAllProductsUseCase mockViewAllProductsUseCase;
  late MockViewProductUsecase mockViewProductUsecase;
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late ProductBloc productbloc;

  const product = ProductEntity(
      id: 'id',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 20);
  const productModel = ProductModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 20);

  final products = [product];

  setUp(() {
    mockViewAllProductsUseCase = MockViewAllProductsUseCase();
    mockViewProductUsecase = MockViewProductUsecase();
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    productbloc = ProductBloc(
        createProductUsecase: mockCreateProductUsecase,
        deleteProductUsecase: mockDeleteProductUsecase,
        updateProductUsecase: mockUpdateProductUsecase,
        viewAllProductsUseCase: mockViewAllProductsUseCase,
        viewProductUseCase: mockViewProductUsecase);
  });

  test('initial state should be AllProductsInitial', () {
    expect(productbloc.state, AllProductsInitial());
  });

  blocTest<ProductBloc, ProductState>(
    'emits [AllProductsLoading, AllProductLoaded] when LoadAllProductEvent is successfull.',
    build: () {
      when(mockViewAllProductsUseCase.call())
          .thenAnswer((_) async => Right(products));

      return productbloc;
    },
    act: (bloc) => bloc.add(LoadAllProductsEvent()),
    expect: () => [
      AllProductsLoading(),
      AllProductsLoaded(products),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [AllProductsLoading, ProductError] when LoadAllProductEvent is failure.',
    build: () {
      when(mockViewAllProductsUseCase.call()).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server Error')));

      return productbloc;
    },
    act: (bloc) => bloc.add(LoadAllProductsEvent()),
    expect: () => [
      AllProductsLoading(),
      ProductError('Server Error'),
    ],
  );

  blocTest<ProductBloc, ProductState>(
      'emit [SingleProductLoading, SingleProductLoaded] when GetSingleProductEvent is successfull',
      build: () {
        when(mockViewProductUsecase.execute(product.id))
            .thenAnswer((_) async => const Right(product));
        return productbloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(product.id)),
      expect: () => [SingleProductLoading(), SingleProductLoaded(product)]);

  blocTest<ProductBloc, ProductState>(
      'emit [SingleProductLoading, ProductError] when GetSingleProductEvent is failure',
      build: () {
        when(mockViewProductUsecase.execute(product.id)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Error')));
        return productbloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(product.id)),
      expect: () => [SingleProductLoading(), ProductError('Server Error')]);

  blocTest<ProductBloc, ProductState>(
      'emit [UpdateProductLoading, UpdateProductLoaded] when UpdateProductEvent is successfull',
      build: () {
        when(mockUpdateProductUsecase.call(productModel))
            .thenAnswer((_) async => const Right(unit));
        return productbloc;
      },
      act: (bloc) async => bloc.add(UpdateProductEvent(productModel)),
      expect: () => [UpdateProductLoading(), UpdateProductLoaded()],
      wait: const Duration(seconds: 2));

  blocTest<ProductBloc, ProductState>(
      'emit [ProductError] when UpdateProductEvent is failure',
      build: () {
        when(mockUpdateProductUsecase.call(productModel)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Error')));
        return productbloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(productModel)),
      expect: () => [UpdateProductLoading(), ProductError('Server Error')],
      wait: const Duration(seconds: 2));

  blocTest<ProductBloc, ProductState>(
      'emit [DeleteProductLoading, DeleteProductLoaded] when DeleteProductEvent is successfull',
      build: () {
        when(mockDeleteProductUsecase.call(productModel.id))
            .thenAnswer((_) async => const Right(unit));
        return productbloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(productModel.id)),
      expect: () => [DeleteProductLoading(), DeleteProductLoaded()],
      wait: const Duration(seconds: 2));
  blocTest<ProductBloc, ProductState>(
      'emit [DeleteProductLoading, ProductError] when DeleteProductEvent is failure',
      build: () {
        when(mockDeleteProductUsecase.call(productModel.id)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Error')));
        return productbloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(productModel.id)),
      expect: () => [DeleteProductLoading(), ProductError('Server Error')],
      wait: const Duration(seconds: 2));

  blocTest<ProductBloc, ProductState>(
      'emit [CreateProductLoading, CreateProductLoaded] when CreateProductEvent is successfull',
      build: () {
        when(mockCreateProductUsecase.call(productModel))
            .thenAnswer((_) async => const Right(unit));
        return productbloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(productModel)),
      expect: () => [CreateProductLoading(), CreateProductLoaded()],
      wait: const Duration(seconds: 2));

  blocTest<ProductBloc, ProductState>(
      'emit [ProductError] when CreateProductEvent is failure',
      build: () {
        when(mockCreateProductUsecase.call(productModel)).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Server Error')));
        return productbloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(productModel)),
      expect: () => [CreateProductLoading(), ProductError('Server Error')],
      wait: const Duration(seconds: 2));
}
