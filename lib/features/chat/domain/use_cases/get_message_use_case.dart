import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/chat_repo.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Stream<QuerySnapshot> call(String chatRoomId) {
    return repository.getMessages(chatRoomId);
  }
}
