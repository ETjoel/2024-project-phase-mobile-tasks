import 'package:get_it/get_it.dart' as get_it;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/image_path/image_path.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/datasource/auth_local.dart';
import 'features/auth/data/datasource/auth_remote.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_respository.dart';
import 'features/auth/domain/usecases/get_user_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/chat/data/datasource/local_datasource/local_datasource.dart';
import 'features/chat/data/datasource/remote_datasource/remote_datasource.dart';
import 'features/chat/data/repository/chat_repository_impl.dart';
import 'features/chat/domain/repository/chat_respository.dart';
import 'features/chat/domain/usecases/delete_chat.dart';
import 'features/chat/domain/usecases/get_chat_message_usecase.dart';
import 'features/chat/domain/usecases/initiate_chat_usecase.dart';
import 'features/chat/domain/usecases/view_my_chats_usecase.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/ecommerce/data/datasource/product_local_datasource.dart';
import 'features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'features/ecommerce/data/repositories/product_respository_impl.dart';
import 'features/ecommerce/domain/repositories/product_respository.dart';
import 'features/ecommerce/domain/usecases/create_new_product_usecase.dart';
import 'features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'features/ecommerce/domain/usecases/update_product_usecase.dart';
import 'features/ecommerce/domain/usecases/view_all_products_usecase.dart';
import 'features/ecommerce/domain/usecases/view_single_product_usecase.dart';
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

  sl.registerFactory(() => AuthBloc(
      loginUseCase: sl(),
      getUserUseCase: sl(),
      registerUserCase: sl(),
      logoutUseCase: sl()));

  sl.registerFactory(() => ChatBloc(
      viewMyChatsUseCase: sl(),
      initiateChatUseCase: sl(),
      getChatMessageUseCase: sl(),
      deleteChatUseCase: sl()));

//usecases
  sl.registerLazySingleton(() => ViewAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(sl()));
  sl.registerLazySingleton(() => CreateProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUserCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ViewMyChatsUseCase(sl()));
  sl.registerLazySingleton(() => InitiateChatUseCase(sl()));
  sl.registerLazySingleton(() => GetChatMessageUseCase(sl()));
  sl.registerLazySingleton(() => DeleteChatUseCase(sl()));

//repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productLocalDataSource: sl(),
      productRemoteDatasource: sl(),
      networkInfo: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      networkInfo: sl()));

  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(sl(), sl(), sl(), sl()));

//datasources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImp(sl()));

  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton<ChatLocalDataSource>(
      () => ChatLocalDataSourceImpl(sl()));
//core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ImagePath>(() => ImagePathImpl(imagePicker: sl()));

//External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => ImagePicker());
}
