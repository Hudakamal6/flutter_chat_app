
import '../../data/data_sources/remote_data source.dart';
import '../../data/repositories/repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<String>> getAllUserEmails() {
    return remoteDataSource.getAllUsers();
  }
}