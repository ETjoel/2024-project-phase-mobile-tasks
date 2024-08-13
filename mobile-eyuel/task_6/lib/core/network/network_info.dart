import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionStatus internetConnectionStatus;
  NetworkInfoImpl({required this.internetConnectionStatus});

  @override
  Future<bool> get isConnected => InternetConnectionChecker().hasConnection;
}
