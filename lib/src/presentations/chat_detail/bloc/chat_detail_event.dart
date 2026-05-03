part of 'chat_detail_bloc.dart';

sealed class ChatDetailEvent {
  const ChatDetailEvent();
}

class LoadConversationEvent extends ChatDetailEvent {
  const LoadConversationEvent();
}

class SendMessageEvent extends ChatDetailEvent {
  final String message;
  const SendMessageEvent({required this.message});
}
