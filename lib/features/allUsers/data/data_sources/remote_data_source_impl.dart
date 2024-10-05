import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/features/allUsers/data/data_sources/remote_data%20source.dart';

class UserRemoteDataSourceImpl extends UserRemoteDataSource{
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firestore});
  @override
  Future<List<String>> getAllUsers() async {
    List<String> emails = [];
    try {
      QuerySnapshot querySnapshot = await firestore.collection('users').get();
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('email')) {
          emails.add(data['email']);

        }
      }
    } catch (e) {
      throw Exception('Error fetching emails: $e');
    }
    return emails;
  }


}