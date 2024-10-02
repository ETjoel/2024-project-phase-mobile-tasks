import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_6/core/network/network_info.dart';
import 'package:task_6/features/auth/data/datasource/auth_local.dart';
import 'package:task_6/features/auth/data/datasource/auth_remote.dart';
import 'package:task_6/features/auth/domain/repository/auth_respository.dart';
import 'package:task_6/features/chat/data/datasource/local_datasource/local_datasource.dart';
import 'package:task_6/features/chat/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:task_6/features/chat/domain/repository/chat_respository.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_local_datasource.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:task_6/features/ecommerce/domain/repositories/product_respository.dart';
import 'package:task_6/features/ecommerce/domain/usecases/create_new_product_usecase.dart';
import 'package:task_6/features/ecommerce/domain/usecases/delete_product_usecase.dart';
import 'package:task_6/features/ecommerce/domain/usecases/update_product_usecase.dart';
import 'package:task_6/features/ecommerce/domain/usecases/view_all_products_usecase.dart';
import 'package:task_6/features/ecommerce/domain/usecases/view_single_product_usecase.dart';
import 'package:task_6/features/ecommerce/presentation/pages/add_product_page.dart';

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
  DeleteProductUsecase,
  ImagePickerController,
  AuthRepository,
  AuthRemoteDataSource,
  AuthLocalDataSource,
  ChatRepository,
  ChatRemoteDataSource,
  ChatLocalDataSource,
])
void main() {}
