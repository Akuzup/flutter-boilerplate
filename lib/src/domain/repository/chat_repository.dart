// ignore_for_file: one_member_abstracts

import '../entities/conversation.dart';
import '../entities/message_completion.dart';

abstract class ChatRepository {
  Future<MessageCompletion?> sendCompletions({
    required String newMessage,
    List<MessageCompletion>? messages,
  });

  Future<List<Conversation>> getConversations();
  Future<Conversation?> getConversation(String id);
  Future<void> saveConversation(Conversation conversation);
  Future<void> deleteConversation(String id);
}
