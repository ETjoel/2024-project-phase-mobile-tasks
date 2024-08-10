class ProductEntity {
  int id;
  String name;
  String description;
  String imageUrl;
  double price;

  ProductEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price});
}
