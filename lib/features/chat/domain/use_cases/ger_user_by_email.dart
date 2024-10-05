import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/chat_repo.dart';

class GetUserByEmail {
  final ChatRepository repository;

  GetUserByEmail(this.repository);

  Future<DocumentSnapshot> call(String email) {
    return repository.getUserByEmail(email);
  }
}
