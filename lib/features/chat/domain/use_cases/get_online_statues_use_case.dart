import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/chat_repo.dart';

class GetOnlineStatusUseCase {
  final ChatRepository repository;

  GetOnlineStatusUseCase(this.repository);

  Stream<DocumentSnapshot> call(String userId) {
    return repository.getOnlineStatus(userId);
  }
}
