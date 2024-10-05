import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/chat_repo.dart';

class GetTypingStatusUseCase {
  final ChatRepository repository;

  GetTypingStatusUseCase(this.repository);

  Stream<DocumentSnapshot> call(String chatRoomId) {
    return repository.getTypingStatus(chatRoomId);
  }
}
