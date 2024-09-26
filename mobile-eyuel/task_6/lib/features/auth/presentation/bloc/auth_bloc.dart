import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final RegisterUserCase registerUserCase;
  final LogoutUseCase logoutUseCase;
  AuthBloc(
      {required this.loginUseCase,
      required this.getUserUseCase,
      required this.registerUserCase,
      required this.logoutUseCase})
      : super(AuthSignInInitial()) {
    on<AuthSignInEvent>((event, emit) async {
      emit(AuthSignInLoading());

      final result = await loginUseCase.call(event.email, event.password);

      result.fold((left) => emit(AuthFailure(left)),
          (right) => emit(AuthSignInSuccess()));
    });

    on<AuthGetUserEvent>((event, emit) async {
      emit(AuthGetUserLoading());

      final result = await getUserUseCase.call();

      result.fold((failure) => emit(AuthFailure(failure)),
          (user) => emit(AuthGetUserSuccess(user)));
    });

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthSignUpLoading());

      final result =
          await registerUserCase.call(event.name, event.email, event.password);

      result.fold((failure) => emit(AuthFailure(failure)),
          (unit) => emit(AuthSignUpSuccess()));
    });

    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthSignOutLoading());

      final reslut = await logoutUseCase.call();

      reslut.fold((failure) => emit(AuthFailure(failure)),
          (unit) => emit(AuthSignOutSuccess()));
    });
  }
}
