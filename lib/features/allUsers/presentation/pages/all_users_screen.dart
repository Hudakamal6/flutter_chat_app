import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/authBloc/auth_cubit.dart';
import 'package:flutter_chat_app/core/routing/routeNames.dart';
import 'package:flutter_chat_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:flutter_chat_app/features/signIn/presentation/manager/log_in_cubit.dart';

import '../../../../core/constants.dart';
import '../manager/user_cubit.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
  Scaffold(

    backgroundColor: Colors.black,
    floatingActionButton: FloatingActionButton(child: const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
      [
        Icon(Icons.logout,size: 20,),
        Text('Log Out', style: TextStyle(fontSize: 14),),

      ],
    ),onPressed: (){


      context.read<LoginCubit>().logOut();
      context.read<AuthCubit>().deleteUserData();
      Navigator.of(context).pushReplacementNamed(RoutesName.signInPage);
    },),
        appBar: AppBar(title: const Center(child: Text('User Emails', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),))),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is GetAllUsersSuccess) {
              context.read<UserCubit>().checkMyEmail(context.read<AuthCubit>().currentUserEmail!, state.userEmails);
             return Padding(
               padding: const EdgeInsets.only(top: 40),
               child: ListView.builder(

                 itemCount: state.userEmails.length,
                 itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: () {
                       context.read<ChatCubit>().receiverEmail = state.userEmails[index];
                       Navigator.pushNamed(context, RoutesName.chatPage);
                     },
                     child: Card(
                       elevation: 10,
                       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25),
                         side: const BorderSide(color: Colors.black, width: 1) ),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           boxShadow: const [
                             BoxShadow(
                               color: Constants.lightPurple,
                               blurRadius: 8,
                               offset: Offset(0, 6),
                             ),
                           ],
                         ),
                         child: ListTile(
                           contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                           title: Text(
                             state.userEmails[index],
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: state.userEmails[index] == context.read<AuthCubit>().currentUserEmail ? FontWeight.bold : FontWeight.normal,
                               color:Colors.white,
                             ),
                           ),
                           leading: state.userEmails[index] == context.read<AuthCubit>().currentUserEmail
                               ? const Text(
                             'Me',
                             style: TextStyle(color: Colors.green, fontSize: 20),
                           )
                               :   const CircleAvatar(
                             radius: 30,
                             backgroundImage: AssetImage('assets/images/userAvatar.jpeg',),
                           )
                           ,
                         ),
                       ),
                     ),
                   );
                 },
               ),
             );


            }
            if (state is GetAllUsersError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            return const Center(child: CircularProgressIndicator(),);
          },
        ),

    );
  }
}
