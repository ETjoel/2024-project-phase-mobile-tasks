import 'package:mockito/annotations.dart';
import 'package:task_6/core/network/network_info.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_local_datasource.dart';
import 'package:task_6/features/ecommerce/data/datasource/product_remote_datasource.dart';
import 'package:task_6/features/ecommerce/domain/repositories/product_respository.dart';

@GenerateMocks([
  ProductRepository,
  ProductLocalDataSource,
  ProductRemoteDatasource,
  NetworkInfo,
])
void main() {}
