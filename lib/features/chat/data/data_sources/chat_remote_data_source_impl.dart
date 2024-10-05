import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_remote_data_source.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
final FirebaseFirestore firestore;

ChatRemoteDataSourceImpl(this.firestore);

@override
Future<void> sendMessage(String chatRoomId, String message, String senderEmail, String receiverEmail) async {
  await firestore.collection('chatRooms').doc(chatRoomId).collection('messages').add({
    'sender': senderEmail,
    'receiver': receiverEmail,
    'message': message,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

@override
Stream<QuerySnapshot> getMessages(String chatRoomId) {
  return firestore
      .collection('chatRooms')
      .doc(chatRoomId)
      .collection('messages')
      .orderBy('timestamp')
      .snapshots();
}

@override
Future<DocumentSnapshot> getUserByEmail(String email) async {
  QuerySnapshot result = await firestore
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  if (result.docs.isNotEmpty) {
    return result.docs.first;
  } else {
    throw Exception('No user found with that email.');
  }
}

@override
Future<void> setOnlineStatus(String userId, bool isOnline) async {
  await firestore.collection('users').doc(userId).update({
    'isOnline': isOnline,
    'lastSeen': FieldValue.serverTimestamp(),
  });
}


@override
Future<void> setTypingStatus(String chatRoomId, String userEmail, bool isTyping) async {
  await firestore.collection('chatRooms').doc(chatRoomId).set({
    '${userEmail}_isTyping': isTyping,
  }, SetOptions(merge: true));
}

@override
Stream<DocumentSnapshot> getTypingStatus(String chatRoomId) {
  return firestore.collection('chatRooms').doc(chatRoomId).snapshots();
}

@override
Stream<DocumentSnapshot> getOnlineStatus(String userId) {
  return firestore.collection('users').doc(userId).snapshots();
}
}