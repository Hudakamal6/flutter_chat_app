import 'package:cloud_firestore/cloud_firestore.dart';


abstract class ChatRepository {
  Future<void> sendMessage(String chatRoomId, String message, String senderEmail, String receiverEmail);
  Stream<QuerySnapshot> getMessages(String chatRoomId);
  Future<DocumentSnapshot> getUserByEmail(String email);
  Future<void> setOnlineStatus(String userId, bool isOnline);
  Future<void> setTypingStatus(String chatRoomId, String userEmail, bool isTyping);
  Stream<DocumentSnapshot> getTypingStatus(String chatRoomId);
  Stream<DocumentSnapshot> getOnlineStatus(String userId);
}