import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/data_sources/chat_remote_data_source.dart';
import '../../data/repositories/chat_repo.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendMessage(String chatRoomId, String message, String senderEmail, String receiverEmail) {
    return remoteDataSource.sendMessage(chatRoomId, message, senderEmail, receiverEmail);
  }

  @override
  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return remoteDataSource.getMessages(chatRoomId);
  }

  @override
  Future<DocumentSnapshot> getUserByEmail(String email) {
    return remoteDataSource.getUserByEmail(email);
  }

  @override
  Future<void> setOnlineStatus(String userId, bool isOnline) {
    return remoteDataSource.setOnlineStatus(userId, isOnline);
  }

  @override
  Future<void> setTypingStatus(String chatRoomId, String userEmail, bool isTyping) {
    return remoteDataSource.setTypingStatus(chatRoomId, userEmail, isTyping);
  }

  @override
  Stream<DocumentSnapshot> getTypingStatus(String chatRoomId) {
    return remoteDataSource.getTypingStatus(chatRoomId);
  }

  @override
  Stream<DocumentSnapshot> getOnlineStatus(String userId) {
    return remoteDataSource.getOnlineStatus(userId);
  }
}