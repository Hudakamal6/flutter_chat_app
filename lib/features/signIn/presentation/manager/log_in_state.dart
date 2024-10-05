part of 'log_in_cubit.dart';
class LoginState {
  final bool isLoading;
  final bool isAuthenticated;
  final String errorMessage;

  LoginState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage = '',
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}