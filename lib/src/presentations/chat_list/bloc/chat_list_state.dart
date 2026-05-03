part of 'chat_list_bloc.dart';

sealed class ChatListState {
  final ChatListStateUi ui;
  const ChatListState({required this.ui});
}

final class ChatListInitial extends ChatListState {
  const ChatListInitial({required super.ui});
}

final class ChatListLoading extends ChatListState {
  const ChatListLoading({required super.ui});
}

final class ChatListLoaded extends ChatListState {
  const ChatListLoaded({required super.ui});
}

final class ConversationDeleted extends ChatListState {
  const ConversationDeleted({required super.ui});
}

final class ChatListError extends ChatListState {
  final String message;
  final dynamic exception;
  const ChatListError({
    required this.message,
    required this.exception,
    required super.ui,
  });
}
