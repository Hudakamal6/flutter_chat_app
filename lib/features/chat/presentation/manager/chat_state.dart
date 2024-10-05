part of 'chat_cubit.dart';

class ChatState {
  final bool isLoading;
  final List<QueryDocumentSnapshot> messages;
  final bool isTyping;
  final bool isOnline;
  final Timestamp? lastSeen;

  ChatState({
    this.isLoading = false,
    this.messages = const [],
    this.isTyping = false,
    this.isOnline = false,
    this.lastSeen,
  });

  ChatState copyWith({
    bool? isLoading,
    List<QueryDocumentSnapshot>? messages,
    bool? isTyping,
    bool? isOnline,
    Timestamp? lastSeen,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}