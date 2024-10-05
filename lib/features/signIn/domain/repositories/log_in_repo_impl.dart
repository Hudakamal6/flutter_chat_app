import 'package:firebase_auth/firebase_auth.dart';

import '../../data/data_sources/log_in_remote_data_source_impl.dart';
import '../../data/repositories/log_in_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<User?> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<void> logOut() async {
    return await remoteDataSource.logOut();
  }
}