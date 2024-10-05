import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/authBloc/auth_cubit.dart';
import 'package:flutter_chat_app/core/routing/routeNames.dart';

import 'package:intl/intl.dart';

import '../../../../core/constants.dart';
import '../manager/chat_cubit.dart';
class ChatScreen extends StatefulWidget {



  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late String chatRoomId;
  bool isTyping = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().senderEmail = context.read<AuthCubit>().currentUserEmail!;

    chatRoomId = getChatRoomId(
        context.read<ChatCubit>().senderEmail!, context.read<ChatCubit>().receiverEmail!);

    context.read<ChatCubit>().fetchMessages(chatRoomId);
    context.read<ChatCubit>().fetchTypingStatus(
        chatRoomId);


    context.read<ChatCubit>().fetchOnlineStatus();
  }

  String getChatRoomId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode ? '$user1-$user2' : '$user2-$user1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Constants.lightPurple,

        actions:  const [
        CircleAvatar(
        radius: 30,  // Size of the avatar
        backgroundImage: AssetImage('assets/images/userAvatar.jpeg',), // Default image
      )


        ],
        title: Center(
          child: Column(
            children: [
              Text(context.read<ChatCubit>().receiverEmail!),
              const SizedBox(width: 10),
              BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state.isOnline) {
                    return const Text(
                        'Online', style: TextStyle(color: Colors.green));
                  } else if (state.lastSeen != null) {
                    String lastSeenTime = DateFormat('hh:mm a').format(
                        state.lastSeen!.toDate());
                    return Text('Last seen at $lastSeenTime',
                        style: const TextStyle(color: Colors.grey));
                  } else {
                    return const Text(
                        'Loading...', style: TextStyle(color: Colors.grey));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body:
      Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.messages.isEmpty) {
                  return const Center(child: Text('No messages yet, start the chat' ,style:  TextStyle(fontSize: 25),));
                }

                return ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    var message = state.messages[index];
                    bool isSender = message['sender'] ==
                        context.read<ChatCubit>().senderEmail;
                    Timestamp timestamp = message['timestamp'] ??
                        Timestamp.now();
                    return _buildMessageBubble(
                        message['message'], isSender, timestamp);
                  },
                );
              },
            ),
          ),
          if (context
              .watch<ChatCubit>()
              .state
              .isTyping)

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                    ' Typing...', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 25, color: Constants.purple)),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText: 'Enter a message...'),
                    onChanged: (value) {
                      if (value.isNotEmpty && !isTyping) {
                        context.read<ChatCubit>().setTypingStatus(
                            chatRoomId,
                            true);
                        setState(() {
                          isTyping = true;
                        });
                      } else if (value.isEmpty && isTyping) {
                        context.read<ChatCubit>().setTypingStatus(
                            chatRoomId,
                            false);
                        setState(() {
                          isTyping = false;
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatCubit>().sendMessage(
                      chatRoomId,
                      _messageController.text,
                      context.read<ChatCubit>().senderEmail!,
                      context.read<ChatCubit>().receiverEmail!,
                    );
                    _messageController.clear();
                    context.read<ChatCubit>().setTypingStatus(
                        chatRoomId, false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isSender,
      Timestamp timestamp) {
    String time = DateFormat('hh:mm a').format(timestamp.toDate());


    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isSender ? Constants.purple : Constants.brown,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
                if (isSender)
                  const SizedBox(width: 4),
                if (isSender)
                  const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white54,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

