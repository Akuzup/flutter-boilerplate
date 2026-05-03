import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/networking/exception/api_exception.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message_completion.dart';
import '../../../domain/usecase/chat_usecase.dart';
import '../state_ui/chat_detail_state_ui.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatUsecase _chatUsecase;
  final String? _conversationId;

  ChatDetailBloc(this._chatUsecase, {String? conversationId})
      : _conversationId = conversationId,
        super(const ChatDetailInitial(ui: ChatDetailStateUi())) {
    on<LoadConversationEvent>(_onLoadConversation);
    on<SendMessageEvent>(_onSendMessage);

    add(const LoadConversationEvent());
  }

  FutureOr<void> _onLoadConversation(
    LoadConversationEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    if (_conversationId == null) {
      // New chat — create empty conversation
      final newConversation = Conversation(
        DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        model: 'gemini-2.5-flash-lite',
        messages: [],
        title: '',
      );
      emit(ChatDetailLoaded(
        ui: state.ui.copyWith(conversation: newConversation),
      ));
      return;
    }

    emit(ChatDetailLoading(ui: state.ui));
    try {
      final conversation = await _chatUsecase.getConversation(_conversationId);
      if (conversation != null) {
        emit(ChatDetailLoaded(
          ui: state.ui.copyWith(conversation: conversation),
        ));
      } else {
        emit(ChatDetailError(
          message: 'Conversation not found',
          exception: null,
          ui: state.ui,
        ));
      }
    } on ApiException catch (e) {
      emit(ChatDetailError(
        message: 'Failed to load conversation: ${e.message}',
        exception: e,
        ui: state.ui,
      ));
    } catch (e) {
      emit(ChatDetailError(
        message: 'An unexpected error occurred',
        exception: e,
        ui: state.ui,
      ));
    }
  }

  FutureOr<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentConversation = state.ui.conversation;
    if (currentConversation == null) return;

    // Add user message immediately
    final userMessage = MessageCompletion(event.message, 'user');
    final updatedMessages = [...currentConversation.messages, userMessage];
    final optimisticConversation = currentConversation.copyWith(
      messages: updatedMessages,
    );

    emit(MessageSending(
      ui: state.ui.copyWith(conversation: optimisticConversation),
    ));

    // Save user message to local storage
    await _chatUsecase.saveConversation(optimisticConversation);

    try {
      final aiResponse = await _chatUsecase.sendCompletions(
        newMessage: event.message,
        messages: currentConversation.messages,
      );

      if (aiResponse != null) {
        final allMessages = [...updatedMessages, aiResponse];
        final title = currentConversation.title.isEmpty
            ? event.message.substring(0, event.message.length.clamp(0, 50))
            : currentConversation.title;

        final completedConversation = optimisticConversation.copyWith(
          messages: allMessages,
          title: title,
        );

        await _chatUsecase.saveConversation(completedConversation);

        emit(MessageSent(
          ui: state.ui.copyWith(conversation: completedConversation),
        ));
      } else {
        emit(ChatDetailError(
          message: 'AI returned empty response',
          exception: null,
          ui: state.ui,
        ));
      }
    } on ApiException catch (e) {
      emit(ChatDetailError(
        message: 'AI service error: ${e.message}',
        exception: e,
        ui: state.ui,
      ));
    } catch (e) {
      emit(ChatDetailError(
        message: 'Failed to get AI response',
        exception: e,
        ui: state.ui,
      ));
    }
  }
}
