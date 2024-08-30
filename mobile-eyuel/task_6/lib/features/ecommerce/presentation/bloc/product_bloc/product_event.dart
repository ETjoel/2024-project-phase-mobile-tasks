part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetSingleProductEvent extends ProductEvent {
  final String id;

  GetSingleProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  final ProductModel product;

  UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateProductEvent extends ProductEvent {
  final ProductModel productModel;

  CreateProductEvent(this.productModel);

  @override
  List<Object?> get props => [productModel];
}
