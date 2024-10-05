import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<User?> login(String email, String password);
  Future<void> logOut();
}
