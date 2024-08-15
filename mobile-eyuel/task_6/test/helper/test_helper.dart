import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6/core/network/network_info.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_local_datasource.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:task_6/features/ecommerce/domain/repositories/product_respository.dart';
import 'package:task_6/features/ecommerce/domain/usecases/create_new_product.dart';
import 'package:task_6/features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'package:task_6/features/ecommerce/domain/usecases/update_product.dart';
import 'package:task_6/features/ecommerce/domain/usecases/view_all_products.dart';
import 'package:task_6/features/ecommerce/domain/usecases/view_single_product.dart';

@GenerateMocks([
  ProductRepository,
  ProductLocalDataSource,
  ProductRemoteDatasource,
  NetworkInfo,
  InternetConnectionChecker,
  SharedPreferences,
  http.Client,
  ViewAllProductsUseCase,
  ViewProductUsecase,
  CreateProductUsecase,
  UpdateProductUsecase,
  DeleteProductUsecase
])
void main() {}
