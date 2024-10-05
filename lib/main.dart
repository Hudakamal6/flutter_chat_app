import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/authBloc/auth_cubit.dart';
import 'package:flutter_chat_app/core/getIt/lof_in.dart';
import 'package:flutter_chat_app/core/routing/AppRouter.dart';
import 'package:flutter_chat_app/features/allUsers/presentation/manager/user_cubit.dart';
import 'package:flutter_chat_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:flutter_chat_app/features/signIn/presentation/manager/log_in_cubit.dart';
import 'package:flutter_chat_app/features/signIn/presentation/pages/sign_in_page.dart';
import 'package:get_it/get_it.dart';

import 'features/allUsers/di.dart';
import 'features/chat/chatDi.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ChatDi().init();
  UsersDi().init();
  LoginDi().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance<AuthCubit>(),
        ), BlocProvider(
          create: (context) => GetIt.instance<UserCubit>()..fetchUserEmails(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<ChatCubit>(),
        ), BlocProvider(
          create: (context) => GetIt.instance<LoginCubit>(),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        onGenerateRoute: appRouter.generateRoute,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        context.read<AuthCubit>().checkUserAuthorized();

        if (state is Authenticated)  {
          context.read<AuthCubit>().verifyLogInState();

          return AppRouter().getAllUsersPage();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
