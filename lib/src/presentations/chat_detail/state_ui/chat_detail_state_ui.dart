import '../../../domain/entities/conversation.dart';

class ChatDetailStateUi {
  final Conversation? conversation;

  const ChatDetailStateUi({
    this.conversation,
  });

  ChatDetailStateUi copyWith({
    Conversation? conversation,
    bool clearConversation = false,
  }) {
    return ChatDetailStateUi(
      conversation: clearConversation ? null : (conversation ?? this.conversation),
    );
  }
}
