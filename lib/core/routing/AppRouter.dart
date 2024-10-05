import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/routing/routeNames.dart';
import 'package:flutter_chat_app/features/allUsers/di.dart';
import 'package:flutter_chat_app/features/allUsers/presentation/manager/user_cubit.dart';
import 'package:flutter_chat_app/features/allUsers/presentation/pages/all_users_screen.dart';
import 'package:flutter_chat_app/features/chat/chatDi.dart';
import 'package:flutter_chat_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:flutter_chat_app/features/chat/presentation/pages/chat_screen.dart';
import 'package:flutter_chat_app/features/signIn/presentation/pages/sign_in_page.dart';
import 'package:flutter_chat_app/features/signUp/presentation/pages/sign_up_page.dart';


class AppRouter {

  Widget getAllUsersPage(){

     return
        UsersPage();
  }
  Widget getChatPage(){

     return
      ChatScreen();

  }



  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case RoutesName.signInPage:
       return MaterialPageRoute(builder: (_) => LoginScreen());
 case RoutesName.signUpPage:
       return MaterialPageRoute(builder: (_) => SignUpScreen());

      case RoutesName.chatPage:

        return MaterialPageRoute(
            builder: (_) =>
               getChatPage());
      case RoutesName.allUsersPage:
        return MaterialPageRoute(builder : (_) => getAllUsersPage());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }





}
