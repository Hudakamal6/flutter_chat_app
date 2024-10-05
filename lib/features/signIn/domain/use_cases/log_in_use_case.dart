import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repositories/log_in_repo.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
