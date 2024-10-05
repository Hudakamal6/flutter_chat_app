import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? uid ;

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {

        await _firestore.collection('users').doc(user.uid).update({
          'isOnline': true,
          'lastSeen': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<void> logOut()async {

    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'isOnline': false,
      'lastSeen': FieldValue.serverTimestamp(), // Update last seen
    });
    await _auth.signOut();

  }


}