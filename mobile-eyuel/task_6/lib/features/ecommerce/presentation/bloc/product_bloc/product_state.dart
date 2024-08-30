part of 'product_bloc.dart';

class ProductState extends Equatable {
  @override
  List<Object?> get props => [throw UnimplementedError()];
}

class AllProductsInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class AllProductsLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class AllProductsLoaded extends ProductState {
  final List<ProductEntity> products;

  AllProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class SingleProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class SingleProductLoaded extends ProductState {
  final ProductEntity product;

  SingleProductLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class UpdateProductLoaded extends ProductState {
  @override
  List<Object?> get props => [];
}

class DeleteProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class DeleteProductLoaded extends ProductState {
  @override
  List<Object?> get props => [];
}

class CreateProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class CreateProductLoaded extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
