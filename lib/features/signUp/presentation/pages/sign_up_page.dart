import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/authBloc/auth_cubit.dart';
import '../../../../core/routing/routeNames.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';
  String confirmPassword = '';
  bool showError = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Center(child: const Text('Sign Up', style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              onChanged: (value) => email = value,
              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration: const InputDecoration(labelText: 'Password' ,prefixIcon: Icon(Icons.password)),
              obscureText: true,
            ),
            TextField(
              onChanged: (value) => confirmPassword = value,
              decoration: const InputDecoration(labelText: 'Confirm Password',prefixIcon: Icon(Icons.confirmation_num)),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (showError)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: () async {
                if (password != confirmPassword) {
                  setState(() {
                    showError = true;
                    errorMessage = 'Passwords do not match';
                  });
                  return;
                }
                try {

                  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  User? user = userCredential.user;

                  if (user != null) {

                    await _firestore.collection('users').doc(user.uid).set({
                      'email': user.email,
                      'uid': user.uid,
                      'isOnline': true,
                      'lastSeen': FieldValue.serverTimestamp(),
                    });


                    context.read<AuthCubit>().storeUserData(email, password);


                    Navigator.of(context).pushReplacementNamed(RoutesName.allUsersPage);
                  }
                } catch (e) {

                  setState(() {
                    showError = true;
                    errorMessage = 'Failed to sign up';
                  });
                }
              },
              child: const Text('Sign Up', style:  TextStyle(color:  Colors.white, fontSize: 20),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RoutesName.signInPage);
              },
              child: const Text('Already have an account? Login', style:  TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}
