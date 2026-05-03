part of 'chat_list_bloc.dart';

sealed class ChatListEvent {
  const ChatListEvent();
}

class LoadConversationsEvent extends ChatListEvent {
  const LoadConversationsEvent();
}

class CreateNewChatEvent extends ChatListEvent {
  const CreateNewChatEvent();
}

class DeleteConversationEvent extends ChatListEvent {
  final String conversationId;
  const DeleteConversationEvent({required this.conversationId});
}
