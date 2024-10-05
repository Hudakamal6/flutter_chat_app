

import '../../data/repositories/chat_repo.dart';

class SetTypingStatusUseCase {
  final ChatRepository repository;

  SetTypingStatusUseCase(this.repository);

  Future<void> call(String chatRoomId, String userEmail, bool isTyping) {
    return repository.setTypingStatus(chatRoomId, userEmail, isTyping);
  }
}