import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/log_in_use_case.dart';
import '../../domain/use_cases/log_out_use_case.dart';

part 'log_in_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final LogOutUseCase logOutUseCase;

  LoginCubit(this.loginUseCase, this.logOutUseCase) : super(LoginState());

  void login(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    try {
      var user = await loginUseCase.call(email, password);
      if (user != null) {
        emit(state.copyWith(isAuthenticated: true, isLoading: false));
      } else {
        emit(state.copyWith(errorMessage: 'Login failed', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void logOut(){
    logOutUseCase.call();

  }


}