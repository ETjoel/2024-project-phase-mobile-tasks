import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failure.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<void> cacheAllProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const cachedProduct = 'CACHED_PRODUCT';
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAllProducts(List<ProductModel> products) async {
    final jsonString =
        jsonEncode(products.map((product) => product.tojson()).toList());
    final result = await sharedPreferences.setString(cachedProduct, jsonString);

    if (!result) {
      throw const CacheFailure(message: 'Cache Error');
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final jsonString = sharedPreferences.getString(cachedProduct);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<ProductModel> products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();

      return Future.value(products);
    } else {
      throw const CacheFailure(message: 'Cache Error');
    }
  }
}
