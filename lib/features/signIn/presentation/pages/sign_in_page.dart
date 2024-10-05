import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/authBloc/auth_cubit.dart';
import 'package:flutter_chat_app/core/constants.dart';
import '../manager/log_in_cubit.dart';

import '../../../../core/routing/routeNames.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Center(child: const Text('Login', style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 40),))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              onChanged: (value) => email = value,
              decoration: const InputDecoration(labelText: 'Email',prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              onChanged: (value) => password = value,
              decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.password)),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.isAuthenticated) {
                  Navigator.of(context).pushReplacementNamed(RoutesName.allUsersPage);
                }
                if (state.errorMessage.isNotEmpty) {
                  setState(() {
                    showError = true;
                  });
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(


                  onPressed: () {
                    context.read<AuthCubit>().storeUserData(email, password);
                    context.read<LoginCubit>().login(email, password);

                  },
                  child: const Text('Login', style:  TextStyle(fontSize: 20 , color:  Colors.white),),
                );
              },
            ),
            if (showError)
              const Text(
                'Login failed',
                style: TextStyle(color: Colors.red),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RoutesName.signUpPage);
              },
              child: const Text('Don’t have an account? Sign Up',  style:  TextStyle(fontSize: 20 ,),),
            ),
          ],
        ),
      ),
    );
  }
}
