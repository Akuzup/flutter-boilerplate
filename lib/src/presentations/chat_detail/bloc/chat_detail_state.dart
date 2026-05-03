part of 'chat_detail_bloc.dart';

sealed class ChatDetailState {
  final ChatDetailStateUi ui;
  const ChatDetailState({required this.ui});
}

final class ChatDetailInitial extends ChatDetailState {
  const ChatDetailInitial({required super.ui});
}

final class ChatDetailLoading extends ChatDetailState {
  const ChatDetailLoading({required super.ui});
}

final class ChatDetailLoaded extends ChatDetailState {
  const ChatDetailLoaded({required super.ui});
}

final class MessageSending extends ChatDetailState {
  const MessageSending({required super.ui});
}

final class MessageSent extends ChatDetailState {
  const MessageSent({required super.ui});
}

final class ChatDetailError extends ChatDetailState {
  final String message;
  final dynamic exception;
  const ChatDetailError({
    required this.message,
    required this.exception,
    required super.ui,
  });
}
