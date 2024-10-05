
import '../../data/repositories/repo.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Future<List<String>> call() {
    return repository.getAllUserEmails();
  }
}
