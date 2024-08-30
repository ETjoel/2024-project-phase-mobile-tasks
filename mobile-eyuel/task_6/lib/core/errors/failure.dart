import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message: message);
}

class AuthFailure extends Failure {
  const AuthFailure() : super(message: 'Auth failure');
}

class ServiceFailure extends Failure {
  const ServiceFailure({required String message}) : super(message: message);
}
