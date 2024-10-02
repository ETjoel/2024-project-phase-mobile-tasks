import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/product_model.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/create_new_product_usecase.dart';
import '../../../domain/usecases/delete_product_usecase.dart';
import '../../../domain/usecases/update_product_usecase.dart';
import '../../../domain/usecases/view_all_products_usecase.dart';
import '../../../domain/usecases/view_single_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUseCase viewAllProductsUseCase;
  final ViewProductUsecase viewProductUseCase;
  final CreateProductUsecase createProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductBloc(
      {required this.viewAllProductsUseCase,
      required this.viewProductUseCase,
      required this.createProductUsecase,
      required this.updateProductUsecase,
      required this.deleteProductUsecase})
      : super(AllProductsInitial()) {
    on<LoadAllProductsEvent>((event, emit) async {
      emit(AllProductsLoading());
      final products = await viewAllProductsUseCase.call();
      products.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(AllProductsLoaded(products)),
      );
    });

    on<GetSingleProductEvent>((event, emit) async {
      emit(SingleProductLoading());
      final result = await viewProductUseCase.execute(event.id);
      result.fold((failure) => emit(ProductError(failure.message)),
          (product) => emit(SingleProductLoaded(product)));
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final result = await updateProductUsecase.call(event.product);
      await Future.delayed(const Duration(seconds: 2));
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (unit) => emit(UpdateProductLoaded()),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(DeleteProductLoading());
      final result = await deleteProductUsecase.call(event.id);
      await Future.delayed(const Duration(seconds: 2));
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (unit) => emit(DeleteProductLoaded()),
      );
    });

    on<CreateProductEvent>((event, emit) async {
      emit(CreateProductLoading());
      final result = await createProductUsecase.call(event.productModel);
      await Future.delayed(const Duration(seconds: 2));
      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (unit) => emit(CreateProductLoaded()),
      );
    });
  }
}
