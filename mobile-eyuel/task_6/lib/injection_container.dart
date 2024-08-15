import 'package:get_it/get_it.dart' as get_it;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/ecommerce/data/datasource/product_local_datasource.dart';
import 'features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'features/ecommerce/data/repositories/product_respository_impl.dart';
import 'features/ecommerce/domain/repositories/product_respository.dart';
import 'features/ecommerce/domain/usecases/create_new_product.dart';
import 'features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'features/ecommerce/domain/usecases/update_product.dart';
import 'features/ecommerce/domain/usecases/view_all_products.dart';
import 'features/ecommerce/domain/usecases/view_single_product.dart';
import 'features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';

final sl = get_it.GetIt.instance;

Future<void> init() async {
//features
  sl.registerFactory(() => ProductBloc(
      viewAllProductsUseCase: sl(),
      viewProductUseCase: sl(),
      createProductUsecase: sl(),
      updateProductUsecase: sl(),
      deleteProductUsecase: sl()));

//usecases
  sl.registerLazySingleton(() => ViewAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));

//repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productLocalDataSource: sl(),
      productRemoteDatasource: sl(),
      networkInfo: sl()));

//datasources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
//core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

//External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
