import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/ger_user_by_email.dart';
import 'package:flutter_chat_app/features/chat/domain/use_cases/set_typing_statues_use_case.dart';

import '../../domain/use_cases/get_message_use_case.dart';
import '../../domain/use_cases/get_online_statues_use_case.dart';
import '../../domain/use_cases/get_typing_statues_use_case.dart';
import '../../domain/use_cases/send_message_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final GetTypingStatusUseCase getTypingStatusUseCase;
  final SetTypingStatusUseCase setTypingStatusUseCase;
  final GetOnlineStatusUseCase getOnlineStatusUseCase;
  final GetUserByEmail getUserByEmail;
  String? receiverEmail;
  String? senderEmail;
  String? receiverUid;

  ChatCubit(
      {required this.sendMessageUseCase,
      required this.getMessagesUseCase,
      required this.getTypingStatusUseCase,
      required this.getOnlineStatusUseCase,
      required this.setTypingStatusUseCase,
      required this.getUserByEmail})
      : super(ChatState());

  void fetchMessages(String chatRoomId) {
    emit(state.copyWith(isLoading: true));

    getMessagesUseCase(chatRoomId).listen((snapshot) {
      emit(state.copyWith(messages: snapshot.docs, isLoading: false));
    });
  }

  void fetchTypingStatus(String chatRoomId) {
    getTypingStatusUseCase(chatRoomId).listen((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        bool isTyping = data['${receiverEmail}_isTyping'] ?? false;
        emit(state.copyWith(isTyping: isTyping));
      }
    });
  }

  void fetchOnlineStatus()  async {
    await getReceiverUid();
    getOnlineStatusUseCase(receiverUid!).listen((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        bool isOnline = data['isOnline'] ?? false;
        Timestamp? lastSeen = data['lastSeen'];
        emit(state.copyWith(isOnline: isOnline, lastSeen: lastSeen));
      }
    });
  }

  Future<void> getReceiverUid() async {
    try {
      DocumentSnapshot userDoc = await getUserByEmail(receiverEmail!);

      receiverUid = userDoc.id;
    } catch (e) {
      print(e);
    }
  }

  void sendMessage(String chatRoomId, String message, String senderEmail,
      String receiverEmail) async {
    await sendMessageUseCase(chatRoomId, message, senderEmail, receiverEmail);
  }

  void setTypingStatus(String chatRoomId, bool isTyping) async {
    await setTypingStatusUseCase(chatRoomId, receiverEmail!, isTyping);
  }
}
