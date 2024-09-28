part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {}

final class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class AuthGetUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, password, email];
}

final class AuthSignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
