import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repositories/log_in_repo.dart';

class LogOutUseCase {
  final LoginRepository repository;

  LogOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.logOut();
  }
}
