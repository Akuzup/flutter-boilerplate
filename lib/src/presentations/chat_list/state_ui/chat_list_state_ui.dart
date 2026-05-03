import '../../../domain/entities/conversation.dart';

class ChatListStateUi {
  final List<Conversation> conversations;

  const ChatListStateUi({
    this.conversations = const [],
  });

  ChatListStateUi copyWith({
    List<Conversation>? conversations,
  }) {
    return ChatListStateUi(
      conversations: conversations ?? this.conversations,
    );
  }
}
