part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthSignInInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSignInLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSignInSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthGetUserLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthGetUserSuccess extends AuthState {
  final UserEntity user;
  AuthGetUserSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

final class AuthSignUpLoadingInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSignUpLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSignUpSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSignOutLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSignOutSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthFailure extends AuthState {
  final Failure failure;

  AuthFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
