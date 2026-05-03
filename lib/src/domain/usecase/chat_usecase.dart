import 'package:injectable/injectable.dart';

import '../entities/conversation.dart';
import '../entities/message_completion.dart';
import '../repository/chat_repository.dart';

@injectable
class ChatUsecase {
  final ChatRepository repository;

  ChatUsecase({required this.repository});

  Future<MessageCompletion?> sendCompletions({
    required String newMessage,
    List<MessageCompletion>? messages,
  }) async {
    return repository.sendCompletions(
      newMessage: newMessage,
      messages: messages,
    );
  }

  Future<List<Conversation>> getConversations() =>
      repository.getConversations();

  Future<Conversation?> getConversation(String id) =>
      repository.getConversation(id);

  Future<void> saveConversation(Conversation conversation) =>
      repository.saveConversation(conversation);

  Future<void> deleteConversation(String id) =>
      repository.deleteConversation(id);
}
