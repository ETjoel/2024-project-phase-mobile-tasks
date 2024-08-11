import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required int id,
      required String name,
      required double price,
      required String description,
      required String imageUrl})
      : super(
            id: id,
            name: name,
            price: price,
            description: description,
            imageUrl: imageUrl);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
