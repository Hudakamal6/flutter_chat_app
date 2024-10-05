
import '../../data/repositories/chat_repo.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(String chatRoomId, String message, String senderEmail, String receiverEmail) {
    return repository.sendMessage(chatRoomId, message, senderEmail, receiverEmail);
  }
}